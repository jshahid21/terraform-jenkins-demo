pipeline {

  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth-js')
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        sh 'echo $SVC_ACCOUNT_KEY | base64 -d > terraform.tfvars'
      }
    }

    stage('TF Plan') {
      steps {

          sh 'terraform init'
          sh 'terraform plan'
      }
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
          sh 'terraform apply -auto-approve'
      }
    }

    stage('Ansible Playbook') {
      steps {
          sh 'sudo ansible-playbook -i /var/lib/jenkins/workspace/tajJS/ansible-playbook/hosts --private-key=/var/lib/jenkins/.ocijs/id_rsa /var/lib/jenkins/workspace/tajJS/ansible-playbook/main.yml'
      }
    }
  }
}
