# rotten-potatoes

## Configuration

MONGODB_DB => Database name

MONGODB_HOST => MongoDB Host

MONGODB_PORT => Port to access MongoDB

MONGODB_USERNAME => MongoDB user

MONGODB_PASSWORD => MongoDB pass

## Pipeline CI/CD

Each time someone makes a change to the code, the pipeline will start building and updating the docker image in the container registry (CI) and then deploying this new version of the image to the kubernetes cluster. (CD)
