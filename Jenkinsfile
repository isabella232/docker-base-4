@Library('github.com/invoca/jenkins-pipeline@v0.1.0')
import com.invoca.docker.*;

pipeline {
    agent { label 'docker' }
    stages {
        stage('Setup') {
            steps {
                script {
                    def imageName = "invocaops/base"
                    def sha = env.GIT_COMMIT
                    def branchName = env.GIT_BRANCH

                    image = new Image(this, imageName, [sha, branchName])
                }
            }
        }

        stage('Test') {
            steps { sh "./test" }
            post { always { junit 'rspec.xml' } }
        }

        stage('Build') {
            steps { script { image.build(gitUrl: env.GIT_URL).tag() } }
        }

        stage('Push') {
            environment {
                DOCKERHUB_USER = credentials('dockerhub_user')
                DOCKERHUB_PASSWORD = credentials('dockerhub_password')
            }
            steps {
                script {
                    new Docker().hubLogin(env.DOCKERHUB_USER, env.DOCKERHUB_PASSWORD)
                    image.push()
                }
            }
        }
    }

    post { always { notifySlack(currentBuild.result) } }
}
