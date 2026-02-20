# 🚀 Project Summary: Terraform-Based Web Application Deployment

## 📌 Project Overview

This project demonstrates how to provision cloud infrastructure and deploy a web application using **Infrastructure as Code (IaC)** with **Terraform on AWS**.

The application is a styled **HTML/CSS website** automatically deployed on an EC2 instance using **Nginx** — without any manual server configuration.

---

## 🏗 Architecture Components Used

The infrastructure was created using Terraform and includes:

- 🧱 Custom VPC  
- 🌐 Public Subnet  
- 🌍 Internet Gateway  
- 🛣 Route Table + Association  
- 🔐 Security Group (HTTP enabled)  
- 💻 EC2 Instance  
- ⚙️ User Data script for automation  

---

## ⚙️ How It Works

1. Terraform provisions the AWS infrastructure.  
2. An EC2 instance launches inside a public subnet.  
3. During instance startup:
   - Nginx is installed automatically.  
   - HTML and CSS files are copied to `/usr/share/nginx/html/`.  
4. The website becomes accessible via the EC2 public IP.

Everything is fully automated — no manual SSH configuration required.

---

## 🎯 Key Features

- ✅ Fully automated infrastructure deployment  
- ✅ Separate HTML & CSS files (clean project structure)  
- ✅ No SSH required (improved security)  
- ✅ Infrastructure + Application deployed together  
- ✅ Reproducible environment using Terraform  

---

## 🔒 Security Approach

- Only HTTP (port 80) is open.  
- SSH port (22) removed to reduce attack surface.  
- Infrastructure isolated inside custom VPC.  

---

## 💡 Tools & Technologies Used

- 🛠 Terraform  
- ☁ AWS  
- 🌐 EC2  
- 🧱 VPC Networking  
- 🖥 Nginx  
- 🎨 HTML & CSS  
