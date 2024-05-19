# JenkinsPractice

## Table of Contents



## 1. Installing Jenkins with Docker

First, pull the docker image for jenkins:
```console
docker run --name jenkins --publish 8080:8080 -v <host_volume>:/var/jenkins_home jenkins/jenkins
```

Then, do the initial setup by submitting the password that's appers on the terminal.

## 2. Add SSH Key in Jenkins Environment

Ensure the jenkins container is run, then we can use this command check our jenkins container:
```console
docker container start jenkins
docker container exec -it jenkins /bin/bash
```

:warning: Notes: check if your container is connected to the internet or not using this command: `curl https://www.google.com`.

After that, we can create the .ssh key for the jenkins environment by using this command:

```console
ssh-keygen -t ed25519 -C "your.email@example.com"
```

## 3. Install Git Plugin

Go to `Dashboard` -> `Manage Jenkins` -> `Manage Plugins`, then we just need to install the `Git` plugin.

## 4. Credentials

Credentials is needed, actually we could use the SSH inside our OS for Jenkins to access something like `Git`, but it's not recommended because we will `setup a few server for Jenkins`.

:warning:Because of that, we need all of the credentials need to saved inside the jenkins. Jenkins has a feature named `Credentials`, it will save our credentials inside Jenkins.

:exclamation:Steps:
- Get your private SSH key
- Go to `Manage Jenkins` -> `Manage Credentials` -> Find a table with `global` and click it
- Click `Add Credentials`
- For `Kind` choose `SSH with private key`
- Choose `global` so everyone can use it
- Write on `ID`: `github-ashry`
- Write on `Description: Github Ashry Ramadhan`
- Write on `Username: ashryramadhan10` this is the user github username
- Click `Private Key` -> `Enter Directly` -> Paste all of you private SSH key from: 
```text
-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
```
* Write on `Passphrase` same as your passphrase for the SSH key

## 5. Git Integration

* Go to `Dashboard` > `<Job>` > Configure
* Add the `git` url
* Add `credentials`
* Determine your `branches`
* Click `Build Now`

## 6. Build Step

Steps:
1. Go to `Dashboard` > `<Job>` > `Configure` > `Build Step`, there are few options we have:
* Execute Windows batch command
* Execute Shell
* Invoke Ant
* Invoke Gradle Script
* Invoke top-level Maven project
* Run with timeout
* Set build status to "pending" on Github commit

2. Click `Build Now`

## 7. Build History

As it's name, it's just a build history. Go to `Build History` > `Trends`.

## 8. Post Build Status

This feature is used for informing a status of a `Job` after build process is complete, such sending an email, slack, notification, etc.

### 8.1. Email Notification Post Build Status

Steps:
1. Install `Email Extension Plugin` by clicking `Update`
2. Restart your Jenkins
3. Go to `Manage Jenkins` > `Configure` > Find `Extended Email Notification`
4. Fill all of the data that needed to do this.
5. Click `Save`

## 9. Copy Job

Go to `Create New Job` > Choose Option `Copy From` and fill the input field.

## 10. Scheduled Job

Similar to `cron job`. You can use [crontab.guru](crontab.guru) as reference.

:exclamation:Check on `Build Triggers` > `Build Periodically` > Fill the field using the `crontab.guru` format

## 11. Poll SCM

This is similar to `Scheduled Job` but only will be updated if there's any changes to the Source Codes.

:exclamation:Check On `Build Triggers` > `Poll SCM` > Fill the field using the `crontab.guru` format

## 12. Disabled Job

If we don't need one of our Jenkins Jobs, there are two ways of how to handle this situations.

1. Delete the Job, we delete it permanently
2. Disabled the job, it just like turn it off the job, and we can turn it on again later in the future

:exclamation:Go to `Job` > `Configure` > `Disabled Project` or `Job` > `Disabled Project`.

## 13. Jenkins Environment Variables

When we are using `Build steps` Jenkins will create the `Environment Variable` that contains information of the `Job` and the `Jenkins` itself.

:warning: We can check all of the environment variables on: `JENKINS_URL/env-vars.html/`. For using the environment variable on the `Shell` or `Batch` we can use `${VARIABLE_NAME}`

## 14. Global Environment Variable

Jenkins has feature to add a new `Environment Varibale` but on `Global` scope, so it can be applied to all of the jobs.

:exclamation:Go to `Manage Jenkins` > `System` > `Global Properties` > `Environment Variables`

## 15. Build Parameters

* Before we can running a job, sometimes we need an input from user for setting up the job.
* Jenkins has a feature named `Build Parameters` which we ask an input from user before we can run the job.
* There are many data types for input params such `string`, `boolean`, `choice`, `secrete`, etc.
* All of the input params will be processed similar like environment variables on Build stage.

:exclamation:Go to `Job` > `Configure` > Then check for `This project is parametized`. We can access these parameters same as environment variables `${PARAMETER_NAME}`.

Example:

With build params type: `choice` named `SCRIPTS`.


1. Add Build Step:
```console
echo ${SCRIPTS}
```
2. Save or Apply
3. Look at the build button, the name will be changed to `Build with Parameters`

## 16. Discard Old Build

Jenkins will save all of the `build history` inside the `.jenkins` folder. By default it will be saved forever. Thus, that's why we need the `Discard Old Build` feature for deleting these saved build history.

:exclamation:When we add this feature, Jenkins will check the status of build history of current Job everytime after running it.

* Go to `Job` > `Configure` > `Discard Old Build`. You can set `Days to keep builds` and `Max # (Number) of builds to keep`.

:warning:It will be triggered after running the next build.

## 17. Build Executor

* Jenkins runs jobs inside an Executor.
* By default it has 2 executors for running a Job.
* If all of the Executors are busy, then the current job need to be wait till one of the Executors are not busy.
* Go to `Manage Jenkins` > `Configure Jenkins` > # of Executors.
* Be wise for determining the # of Executors, it will run seperately/parallel and will consume a lot of your CPU and Memory.

## 18. User Management

* The first time while we setting our Jenkins, we automatically creating a `User`.
* If we want to add more user Go to `Manage Jenkins` > `Manage User` > `Create User`

### 18.1. Anonymouse Read Only

We can give `Read Only` for Guest user. Guest user can't see all of the Jobs. Go to `Manage Jenkins` -> `Configure Global Security` -> `Authorization` -> `Logged-in` -> `Allow Anonymous Read Access`

### 18.2. Role Based Authorization Strategy

* By default when we are creating a User it will granted to all of the features of Jenkins, similar like admin user.
* Sometimes we want to restrict the access for some users. Unfortunately, Jenkins can't do this by default.
* But, there's a plugin `Role Based Authorization Strategy` that can be used for this case. [https://plugins.jenkins.io/role-strategy/](https://plugins.jenkins.io/role-strategy/).
* Go to `Manage Jenkins` > `Configure Global Security` or `Security` > On `Authorization` Section > Choose `Role Based Strategy`
* New menu will be created `Manage and Assign Roles`
* Add new roles by fill the `Role to Add`
* On `Assign Roles` section, you can assign the new role
* On `Assign Roles` you can `Add User` from `User`.

## 19. Trigger Build Remotely

* Jenkins has a feature to running a `Job` remotely
* Remote term in here means without opening the Jenkins web
* This feature really fit if we create a Bot, then the Bot can command Jenkins to runs the `Job` that we ask to run
* This feature need `Authentication Token`, the token will be used to run the `Job` remotely.

Steps:
1. Add `Build Trigger Remotely` Token
2. Copy `JENKINS_URL/job/Belajar%20Build%20Trigger%20Remotely/build?token=TOKEN_NAME`

## 19. View

* `View` is a group of `Jobs`
* We can create it on `Dasboard`, for current UI, the `Add` button is on the `Jobs` table, written `Net View`

## 20. Nodes

* Jenkins on `Single Node` is not recommended
* Jenkins support `Nodes` or `Agents` used for running the `Job`
* We don't to setup all of the Jenkins Nodes on every VM, we just need the `Nodes` or `Agents`
* Go to `Manage Jenkins` > `Manage Nodes and Clouds` > `New Node`
* Before add `New Node` we need to prepare the `VM` or `Container` e.g: `jenkins/inbound-agent` image

```yaml
version: '3'
services:
  jenkins-agent:
    image: jenkins/inbound-agent
    container_name: jenkins_agent1
    volumes:
      - /path/on/host:/home/jenkins/agent
    environment:
      - JENKINS_AGENT_WORKDIR=/home/jenkins/agent
      - JENKINS_URL=http://<jenkins-master-url>:8080
      - JENKINS_SECRET=<agent-secret-key>
      - JENKINS_AGENT_NAME=<agent-name>
    ports:
      - 8081:8080
```
* Jenkins Master need a communication protocol to communicate with each Agents, it can use `SSH Build Agent`
* Install `SSH Build Agent` or `SSH Agent` plugin
* Go to `Manage Jenkins` > `Manage Nodes`, fill the `Node Name` and choose `Permanent Agent`
* 














