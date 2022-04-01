pipeline {
  agent {
    node {
      label "worker-one"
    }
  }
  tools {
    maven 'Maven'
  }
  parameters {
    booleanParam(name: "IS_CLEANWORKSPACE", defaultValue: "true", description: "Set to false to disable folder cleanup, default true.")
    booleanParam(name: "IS_DEPLOYING", defaultValue: "true", description: "Set to false to skip deployment, default true.")
    booleanParam(name: "IS_TESTING", defaultValue: "false", description: "Set to false to skip testing, default true!")
  }
  environment {
    AWS_ACCOUNT_ID = credentials("AWS_ACCOUNT_ID")
    AWS_PROFILE = credentials("AWS_PROFILE")
    COMMIT_HASH = "${sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()}"
    DOCKER_IMAGE = "account"
    ECR_REGION = credentials("AWS_REGION")
  }

  stages {
<<<<<<< HEAD
    stage("Fetch Submodules") {
      steps {
        sh "git submodule init"
        sh "git submodule update"
      }
    }
=======
>>>>>>> fdcf3a316a6c0a5183b40e89574fda712f57c84c
    stage("Test") {
      steps {
        script {
          if (params.IS_TESTING) {
            sh "mvn clean test"
          }
        }
      } 
    }   
    stage("Package Artifact") {
      steps {
<<<<<<< HEAD
        sh "mvn package -DskipTests"
=======
        sh "git submodule init"
        sh "git submodule update"
        sh "mvn package"
>>>>>>> fdcf3a316a6c0a5183b40e89574fda712f57c84c
      }
    } 
    stage("SonarQube") {
      steps {
        withSonarQubeEnv("us-west-1-sonar") {
<<<<<<< HEAD
          sh "mvn verify sonar:sonar -Dmaven.test.failure.ignore=true"
=======
          sh "mvn verify sonar:sonar"
>>>>>>> fdcf3a316a6c0a5183b40e89574fda712f57c84c
        }
      }
    }
    stage("Await Quality Gate") {
      steps {
        waitForQualityGate abortPipeline: true
      }
    }
    stage("Upstream to ECR") {
      steps {
        upstreamToECR()
      }
    }
    stage("Fetch Environment Variables"){
      steps {
        sh "aws lambda invoke --function-name getServiceEnv env --profile $AWS_PROFILE"
        createEnvFile()
      }
    }
    stage("Deploy to ECS"){
      steps {
        sh "docker context use prod-jd"
        sh "docker compose -p $DOCKER_IMAGE-jd --env-file service.env up -d"
      }
    }
  }
  post {
    cleanup {
      script {
        sh "docker context use default"
        sh "rm -rf ./*"
        sh "docker image prune -af"
      }
    }
  }
}

def createEnvFile() {
<<<<<<< HEAD
  def env = sh(returnStdout: true, script: """cat ./env | jq -r '.["body"]' | base64 --decode""").trim()
=======
  def env = sh(returnStdout: true, script: """cat ./env | jq '.["body"]'""").trim()
  env = sh(returnStdout: true, script: """echo ${env} | base64 --decode""").trim()
>>>>>>> fdcf3a316a6c0a5183b40e89574fda712f57c84c
  writeFile file: 'service.env', text: env
}

def upstreamToECR() {
  if (params.IS_DEPLOYING) {
<<<<<<< HEAD
=======
    env.CURRENT_HASH = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
>>>>>>> fdcf3a316a6c0a5183b40e89574fda712f57c84c
    sh "cp $DOCKER_IMAGE-microservice/target/*.jar ."
    sh "docker context use default"
    sh 'aws ecr get-login-password --region $ECR_REGION --profile joshua | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com'
    sh "docker build -t ${DOCKER_IMAGE} ."
<<<<<<< HEAD
    sh 'docker tag $DOCKER_IMAGE:latest $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:$COMMIT_HASH'
    sh 'docker tag $DOCKER_IMAGE:latest $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:latest'
    sh 'docker push $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:$COMMIT_HASH'
    sh 'docker push $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:latest'
  }
}
=======
    sh 'docker tag $DOCKER_IMAGE:latest $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:$CURRENT_HASH'
    sh 'docker tag $DOCKER_IMAGE:latest $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:latest'
    sh 'docker push $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:$CURRENT_HASH'
    sh 'docker push $AWS_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com/$DOCKER_IMAGE-microservice-jd:latest'
  }
}
>>>>>>> fdcf3a316a6c0a5183b40e89574fda712f57c84c
