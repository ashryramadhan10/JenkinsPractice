#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Debug information
echo "Starting Jenkins Swarm Agent..."
echo "Jenkins Master URL: ${JENKINS_MASTER_URL}"
echo "Agent Name: ${JENKINS_AGENT_NAME}"
echo "Agent Labels: ${JENKINS_AGENT_LABELS}"

# Start the Swarm client
exec java -jar /usr/local/bin/swarm-client.jar \
  -disableSslVerification \
  -master "${JENKINS_MASTER_URL}" \
  -username "${JENKINS_USERNAME}" \
  -password "${JENKINS_PASSWORD}" \
  -name "${JENKINS_AGENT_NAME}" \
  -labels "${JENKINS_AGENT_LABELS}" \
  -executors 1
