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

## 8. Script

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



