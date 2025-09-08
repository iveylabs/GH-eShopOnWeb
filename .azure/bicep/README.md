# Bicep Templates

This directory contains Bicep templates used for deploying Azure resources as part of this project.

## Overview

Bicep is a domain-specific language (DSL) for deploying Azure resources declaratively. The templates in this directory help automate the provisioning and management of cloud infrastructure.

## Usage

To deploy a template, use the Azure CLI:

```sh
az deployment sub create --location <location> --template-file <template>.bicep --parameters <parameters>
