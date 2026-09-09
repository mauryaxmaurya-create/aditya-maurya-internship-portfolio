# FreshBasket Highly Available AWS Architecture

## Overview

This project designs and validates a highly available AWS architecture for FreshBasket, a web application that needs to scale with demand while protecting application and database resources.

## Architecture

- Elastic Beanstalk for managed application deployment
- Application Load Balancer for traffic distribution
- EC2 Auto Scaling group across two Availability Zones
- Capacity range of 2–8 instances
- Scale-out threshold above 60% CPU utilisation
- Scale-in threshold below 30% CPU utilisation
- Amazon RDS for MySQL with Multi-AZ deployment
- VPC, public/private subnet design and security-group controls
- Amazon SNS notifications and operational monitoring

## Design rationale

The design removes single-instance dependency at the application tier, distributes traffic across Availability Zones and provides managed database failover. The web tier accepts only intended inbound traffic, while database access is limited to the application security group. Auto Scaling adjusts capacity without exposing the database directly to the internet.

## Validation

The supporting report records deployment configuration, database connectivity, scaling settings, availability design and security controls. It also explains how the architecture would respond to instance failure, demand changes and database disruption.

## Repository contents

- `docs/architecture_and_deployment_report.pdf` — implementation and design report

## Project context

Individual university project completed for Cloud Computing and Software as a Service.
