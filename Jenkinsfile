/**
 * This pipeline will build and deploy a Docker image with Kaniko
 * https://github.com/GoogleContainerTools/kaniko  without needing a Docker host
 *
 * You need to create a jenkins-docker-cfg secret with your docker config
 * as described in
 * https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-secret-in-the-cluster-that-holds-your-authorization-token
 *
 * ie.
 * kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=<your username>
  --docker-password=<your-password> --docker-email=john@doe.com
 */

pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      defaultContainer 'kaniko'
      yaml '''
        kind: Pod
        spec:
          containers:
          - name: kaniko
            image: gcr.io/kaniko-project/executor:v1.6.0-debug
            imagePullPolicy: Always
            command:
            - sleep
            args:
            - 99d
            volumeMounts:
              - name: jenkins-docker-cfg
                mountPath: /kaniko/.docker
          volumes:
          - name: jenkins-docker-cfg
            projected:
              sources:
              - secret:
                  name: mbarrera-regcred
                  items:
                    - key: .dockerconfigjson
                      path: config.json
'''
    }
  }
  stages {
    stage('Build container image with Kaniko') {
      steps {
        container('kaniko') {
        //git 'https://github.com/mbarrera-sct/jenkins.git'
        sh '/kaniko/executor -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --cache=true --destination=nexus:5001/test-kaniko:1.0'
        }
      }
    }
  }
}
