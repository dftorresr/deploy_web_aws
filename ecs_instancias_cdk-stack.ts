import * as cdk from '@aws-cdk/core';
// import * as sqs from '@aws-cdk/aws-sqs';

import * as ec2 from "@aws-cdk/aws-ec2";            // Allows working with EC2 and VPC resources
import * as iam from "@aws-cdk/aws-iam";            // Allows working with IAM resources
import * as s3assets from "@aws-cdk/aws-s3-assets"; // Allows managing files with S3
import * as keypair from "cdk-ec2-key-pair";        // Helper to create EC2 SSH keypairs
import * as path from "path";                       // Helper for working with file pa



export class EcsInstanciasCdkStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here
	
	// Look up the default VPC
      const vpc = ec2.Vpc.fromLookup(this, "VPC", {
        isDefault: true
      });
	  
	  const role = iam.Role.fromRoleArn(this, 'Role', 'arn:aws:iam::xxxxxx', {
	// Set 'mutable' to 'false' to use the role as-is and prevent adding new
	// policies to it. The default is 'true', which means the role may be
	// modified as part of the deployment.
	mutable: false,
	});
	  
	
	// Security group for the EC2 instance
    const securityGroup = new ec2.SecurityGroup(this, "SecurityGroup", {
      vpc,
      description: "security group taller",
      allowAllOutbound: true,
    });
	
	// Allow SSH access on port tcp/22
    securityGroup.addIngressRule(
      ec2.Peer.anyIpv4(),
      ec2.Port.tcp(22),
      "Allow SSH Access"
    );

    // Allow HTTP access on port tcp/4568
    securityGroup.addIngressRule(
      ec2.Peer.anyIpv4(),
      ec2.Port.tcp(4568),
      "Allow app Access"
    );
	
	// Look up the AMI Id for the Amazon Linux 2 Image with CPU Type X86_64
    const ami = new ec2.AmazonLinuxImage({
      generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2,
      cpuType: ec2.AmazonLinuxCpuType.X86_64,
    });
	
	// Create the EC2 instance1 using the Security Group, AMI, and KeyPair defined.
    const ec2Instance1 = new ec2.Instance(this, "Instance1", {
      vpc,
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T2,
        ec2.InstanceSize.MICRO
      ),
      machineImage: ami,
      securityGroup: securityGroup,
      keyName: 'keyinstancia1',
      role: role,
    });
	
	// Create the EC2 instance2 using the Security Group, AMI, and KeyPair defined.
    const ec2Instance2 = new ec2.Instance(this, "Instance2", {
      vpc,
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T2,
        ec2.InstanceSize.MICRO
      ),
      machineImage: ami,
      securityGroup: securityGroup,
      keyName: 'keyinstancia2',
      role: role,
    });
	
	// Create the EC2 instance3 using the Security Group, AMI, and KeyPair defined.
    const ec2Instance3 = new ec2.Instance(this, "Instance3", {
      vpc,
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T2,
        ec2.InstanceSize.MICRO
      ),
      machineImage: ami,
      securityGroup: securityGroup,
      keyName: 'keyinstancia3',
      role: role,
    });
	
		

    // example resource
    // const queue = new sqs.Queue(this, 'EcsInstanciasCdkQueue', {
    //   visibilityTimeout: cdk.Duration.seconds(300)
    // });
  }
}
