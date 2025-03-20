<a name="readme-top"></a>

<!--
!!! IMPORTANT !!!
This README is an example of how you could professionally present your codebase.
Writing documentation is a crucial part of your work as a professional software developer and cannot be ignored.

You should modify this file to match your project and remove sections that don't apply.

REQUIRED SECTIONS:
- Table of Contents
- About the Project
  - Built With
  - Live Demo
- Getting Started
- Authors
- Future Features
- Contributing
- Show your support
- Acknowledgements
- License

OPTIONAL SECTIONS:
- FAQ

After you're finished please remove all the comments and instructions!

For more information on the importance of a professional README for your repositories: https://github.com/microverseinc/curriculum-transversal-skills/blob/main/documentation/articles/readme_best_practices.md
-->
  <h3><b>RoR Demo Blog</b></h3>

</div>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
- [👥 Authors](#authors)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)

<!-- PROJECT DESCRIPTION -->

# 📖 [RoR Demo Blog] <a name="about-project"></a>

> RoR Demo Blog that support Users Authenthication with Devise, Authorization with CanCanCan and data persistance with a PostgreSQL local database.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

> Ruby, Ruby on Rails, ERB and SQL DB

<!-- Features -->

### Key Features <a name="key-features"></a>

- **Basic User Interaction with Posts such as CRUD Operations, Liking and Commenting**
- **Authentication and Authorization with Devise and CanCanCan**
- **Both an UI using the Rails Server and an API Mode to interact with Postman**

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

#### Ruby

#### Ruby On Rails

#### PostgreSQL

### Setup

Clone this repository to your desired folder:

```sh
  cd my-folder
  git clone https://github.com/tacodevtripa/RoR.git
  cd demo-blog
```

-

### Install

Install this project with:

```sh
  bundle install
```

### Set up PostgreSQL DB

Development Environment

```sh
  rails db:create
```

```sh
  rails db:migrate
```

Test Environment

```sh
  ruby -e "ENV['RAILS_ENV'] = 'test'; load 'bin/rails'" db:create
```

```sh
  ruby -e "ENV['RAILS_ENV'] = 'test'; load 'bin/rails'" db:migrate
```

### Usage

To run the project, execute the following command:

```sh
  rails server
```

-

### Run tests

To run tests, run the following command:

```sh
  rspec
```

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

👤 **Author1**

- GitHub: [@githubhandle](https://github.com/tacodevtripa)

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).
