#!/usr/bin/groovy
@Library('jenkins-pipeline@v0.4.5')
import com.invoca.docker.*;

pipeline {
  agent { 
    kubernetes {
      defaultContainer "docker"
      yamlFile "./image_build_pod.yml"
    }
  }
  stages {
    stage('Test') {
      agent { 
        kubernetes { 
          defaultContainer "rspec"
          yamlFile "./image_build_pod.yml"
        }
      }
      steps { sh "rspec --format documentation --format RspecJunitFormatter --out ./reports/rspec.xml spec" }
      post { always { junit 'reports/rspec.xml' } }
    }
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
