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