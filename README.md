# docker-base
This Debian Base Image is used for all of Invoca's Docker images. In order to keep things DRY, we start here with a series of packages that we assert will be in all subsequent images.

## Usage

Using the base image as a starting point is simple

```dockerfile
FROM invocaops/base:production
# rest of your Docker file
# here...
```

### Versioning

We tag every successful build with its SHA. Additionally, if the build is on the `master` branch it'll be tagged `latest`. `production` will be tagged `production`.

- `invocaops/base:SHA`: Specific build
- `invocaops/base:latest`: Stable changes that have been merged to master after development
- `invocaops/base:production`: This is essentially our `latest`. Except `latest` is bad. So we control it with a merge to `production`.

## Testing

Our `spec/` describes our minimum requirements of a Docker image. If an upstream image passes these tests it is acceptable for use in production. Otherwise we'll build our own!

The `test` wrapper can be used to (by default) integration test our base image or, an optional image name can be provided to test other upstream images.

```bash
➭ ./test --image debian:9
...
Finished in 3.2 seconds (files took 0.46052 seconds to load)
19 examples, 11 failures
```
