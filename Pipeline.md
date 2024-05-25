# Pipeline

## 1. Install Pipeline Plugin

Go to `Manage Jenkins` > `Manage Plugins` > Seach for `Pipeline`

## 2. Pipeline Basic Scripts

Go to `New Item` > Choose `Pipeline` > Fill below script on `Pipeline`:

```groovy
pipeline {
    agent any
    stages {
        stage("hello") {
            steps {
                echo("Hello Pipeline")
            }
        }
    }
}
```

## 3. Jenkinsfile

It's just a file named `Jenkinsfile` with jenkins pipeline inside of it.

## 4. Agent

```groovy
pipeline {
    agent {
        node {
            label "jenkins_agent1"
        }
    }
    stages {
        stage("hello") {
            steps {
                echo("Hello Pipeline with jenkins_agent1")
            }
        }
    }
}
```

## 5. Post

```groovy
pipeline {
    agent {
        node {
            label "jenkins_agent1"
        }
    }
    stages {
        stage("hello") {
            steps {
                echo("Hello Pipeline with jenkins_agent1")
            }
        }
    }

    post {
        always {
            echo "always be executed"
        }
        changed {
            echo "condition changed will be executed"
        }
        fixed {
            echo "will be executed if error resolve"
        }
        regression {
            echo "will be executed if from success to error"
        }
        aborted {
            echo "will be executed if the pipeline is aborted manually"
        }
        failure {
            echo "if status pipeline error"
        }
        success {
            echo "if status pipeline success"
        }
        cleanup {
            echo "always be executed after previous post"
        }
    }
}
```

## 6. Stages

Tips: Install Jenkins Plugin `Stages View`

```groovy
stages {
    stage("Build") {
        steps {
            echo("Build Stage")
        }
    }
    stage("Test") {
        steps {
            echo("Test Stage")
        }
    }
    stage("Deploy") {
        steps {
            echo("Deploy Stage")
        }
    }
}
```

## 7. Steps

### 7.1. Basic Steps

[https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/](https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/)

Example:

```groovy
steps {
    echo 'Sleeping for 5 seconds'
    sleep(5)
}
```

### 7.2. Nodes and Process Steps

[https://www.jenkins.io/doc/pipeline/steps/workflow-durable-task-step/](https://www.jenkins.io/doc/pipeline/steps/workflow-durable-task-step/)

We will try to use one of the steps: `sh`.

```groovy
steps {
    sh "echo $HOME"
}
```

### 7.3. Script

`Script` is used for a complex pipeline. It use groovy language. [https://groovy-lang.org/](https://groovy-lang.org/)

```groovy
stages {
    stage("Build") {
        steps {
            echo "Start Looping:"
            script {
                for (int i = 0; i <10; i++) {
                    echo "Script ${i}"
                }
            }
        }
    }
}
```

### 7.4. Utility Step

[https://www.jenkins.io/doc/pipeline/steps/pipeline-utility-steps/](https://www.jenkins.io/doc/pipeline/steps/pipeline-utility-steps/)

```groovy
script {
    def data = [
        "firstName": "Ashry",
        "lastName": "Ramadhan"
    ]
    writeJSON(file: "data.json", json: data)
}
```

### 7.5. Other Steps

You can check all of the steps here:
[https://www.jenkins.io/doc/pipeline/steps/](https://www.jenkins.io/doc/pipeline/steps/)

## 8. Agent Per Stage

In case of we need a different agents for each stage. We need to set `agent` to `none`.

```Groovy
pipeline {
    agent none
    stages {
        stage("Build") {
            agent {
                node {
                    label "jenkins_agent1"
                }
            }
        }
    }
}
```

## 9. Global Variable

Go to `Job` > `Pipeline Syntax` > `Global Variables Referece`

### 9.1. Env Varibale

`env` variable is a variable that we can use to get the Global Variable.

`currentBuild` can be used for getting information regarding the current process build.

```groovy
steps {
    echo "Start Job: ${env.JOB_NAME}"
    echo "Start Build: ${env.BUILD_NUMBER}"
    echo "Branch Name: ${env.BRANCH_NAME}"
}
```

## 10. Environment

* Pipeline has a feautre to add `environment` variable
* If we add it below `pipeline` then all of the stages can access it.
* If we add it below a `stage`, then only that stage can access it.

```groovy
pipeline {
    ...
    environment {
        AUTHOR_NAME = "Ashry Ramadhan"
    }

    stages {
        stage("Build") {
            environment {
                STAGE_NAME = "Build"
            }
            echo "Author: ${AUTHOR_NAME}"
            echo "STAGE_NAME: ${STAGE_NAME"}
        }
        ...
    }
    ...
}
```

## 11. Credentials

* `credentials` keyword is used to get the credentials from Jenkins Credentials. 
* This way is more secure rathen than we write it manually in the Jenkinsfile.
* Not all of the credentials is supported.

### 11.1. Credential Types

* Secret Text: `value of secret text`
* Secret File: `path`
* Username and Password: environment variable of `USER_NAME` and `USER_PASSWORD`
* SSH with private key: `path` and `environment variable`

```groovy
environment {
    // APP = credentials("<ID>")
    APP = credentials("ashry-ramadhan")
}
```






