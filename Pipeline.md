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
```


