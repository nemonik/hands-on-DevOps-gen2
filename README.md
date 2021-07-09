[![GitHub license](https://img.shields.io/github/license/nemonik/hands-on-DevOps-gen2)](./LICENSE)
[![GitHub Forks](https://img.shields.io/github/forks/nemonik/hands-on-DevOps-gen2?style=social)](https://github.com/nemonik/hands-on-DevOps-gen2/network/members)
[![Github Stars](https://img.shields.io/github/stars/nemonik/hands-on-DevOps-gen2?style=social)](https://github.com/nemonik/hands-on-DevOps-gen2/stargazers)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Fnemonik%2Fhands-on-DevOps-gen2)](https://twitter.com/intent/tweet?text=I%27ve%20found%20a%20nifty%20hands-on%20DevOps%20course%20developed%20by%20%40nemonik%20at%20https%3A%2F%2Fgithub.com%2Fnemonik%2Fhands-on-DevOps-gen2)

# 1. Preface

The future home of the second edition of my hands-on DevOps course building upon [nemonik/hands-on-DevOps](https://github.com/nemonik/hands-on-DevOps).

The content of this course is presently under development.

This newest version of my Hands-on DevOps class is a replaitforming of sorts -- A sort of rewrite if you will. The prior version relied on multiple Vagrants and was a beast to maintain. Vagrants are virtual machines, when singular is abbreviated as "VM". Several Vagrants were created through automation to run a multi-node Kubernetes cluster as well asa development VM. The approach modeled how I preflighted my work on my laptop vice using [minikube](https://github.com/kubernetes/minikube). The Kubernetes cluster my class used made use of was [k3s](https://k3s.io/) and as it matured [k3d](https://k3d.io/) was introduced. K3d is a lightweight wrapper to run k3s in [Docker](https://docker.com) and provides a rather elegant solution to create and manage a single or multi-node k3s cluster for development vice standing up multi-VMs and the burden they impose on the host (in my case my laptop). Around this same time I was considerinf using k3d I gave [Docker Desktop's](https://www.docker.com/products/docker-desktop) means of providing a Kubernetes cluster a try, but I found it lacking, so I stuck with k3d. Around this same time I also moved fully off my MacBook for personal development moving to [Arch Linux](https://archlinux.org/) where I used [docker-ce](https://github.com/docker/docker-ce). This new version of my class infrastructure-as-code automation focuses instead of directly configuring the host or if need be a single Vagrant for the purpose of development.

# 2. DevOps

A hands-on DevOps course covering the culture, methods and repeated practices of modern software development involving Vagrant, VirtualBox, Ansible, Kubernetes, k3s, k3d, Traefik, Docker-Compose, Docker, Taiga, GitLab, Drone CI, SonarQube, Selenium, InSpec, Heimdall, Arch Linux...

A reveal.js presentation written to accompany this course can found at [https://nemonik.github.io/hands-on-DevOps/](https://nemonik.github.io/hands-on-DevOps/).

This course will

1. Discuss DevOps,
2. Have you spin up a DevOps toolchain and development environment, and then
3. Author two applications and their accompanying pipelines, the first a continuous integration (CI) and the second a continuous delivery (CD) pipeline.

After this course, you will

1. Be able to describe and have hands-on experience DevOps methods and repeated practices (e.g., use of Agile methods, configuration management, build automation, test automation and deployment automation orchestrated under a CICD orchestrator), and why it matters;
2. Address challenges transitioning to DevOps methods and repeated practices;
3. Have had hands-on experience infrastructure-as-code to provision and configure an entire DevOps Factory (i.e. a toolchain and development environment) including Docker Registry, a Kubernetes cluster, Taiga, GitLab, Drone CI, SonarQube, Heimdall;
4. Have had hands-on experience authoring code to include authoring and running automated tests in a CICD pipeline all under Configuration Management to ensure an application follows style, adheres to good coding practices, builds, identify security issues, and functions as expected;
5. Have had hands-on experience with
   1. using Infrastructure as Code (IaC) in Vagrant and Ansible;
   2. creating and using Kanban board in Taiga;
   3. code configuration in git and GitLab;
   4. authoring code in Go;
   5. using style checkers and linters;
   6. authoring a Makefile;
   7. various commands in Docker (e.g., building a container image, pushing a container into a registry, creating and running a container);
   8. authoring a pipeline for Drone CI;
   9. using Sonar Scanner CLI to perform static analysis;
   10. authoring security test in InSpec;
   11. author an automated functional test in Selenium;
   12. authoring a dynamic security test in OWASP Zap; and
   13. using container platform to author and scale services;
6. Have had hands-on experience authoring code to include authoring and running automated tests in a CICD pipeline all under Configuration Management to ensure an application follows style, adheres to good coding practices, builds, identify security issues, and functions as expected.

We will be spending most of the course hands-on working with the tools and in the Unix command line making methods and repeated practices of DevOps happen, so as to grow an understanding of how DevOps actually works. Although, not necessary I would encourage you to pick up a free PDF of [The Linux Command Line by William Shotts](http://linuxcommand.org/tlcl.php) if you are no familiar wit the Linux command line.

Don't fixate on the tools used, nor the apps we develop in the course of learning how and why. How and why is far more important. This course like DevOps is not about tools although we'll be using them. You'll spend far more time writing code. (Or at the very least cutting-and-pasting code.)

# 3. Author

- Michael Joseph Walsh [mjwalsh@mitre.org](mailto:mjwalsh@mitre.org), [walsh@nemonik.com](mailto:walsh@nemonik.com)

# 4. Copyright and license

See the [License file](LICENCE) at the root of this project.

# 5. What you should bring

The following skills would be useful in following along but aren't strictly necessary.

What you should bring:

- Managing Linux or Unix-like systems would be tremendously helpful, but not necessary, as we will be living largely within the terminal.
- A basic understanding of Vagrant, Docker, and Ansible would also be helpful, but not necessary.

# 6. Table of Contents

<!-- TOC -->

- [1. Preface](#1-preface)
- [2. DevOps](#2-devops)
- [3. Author](#3-author)
- [4. Copyright and license](#4-copyright-and-license)
- [5. What you should bring](#5-what-you-should-bring)
- [6. Table of Contents](#6-table-of-contents)
- [7. DevOps unpacked](#7-devops-unpacked)
  - [7.1. What is DevOps?](#71-what-is-devops)
  - [7.2. What DevOps is not](#72-what-devops-is-not)
  - [7.3. To succeed at DevOps you must](#73-to-succeed-at-devops-you-must)
  - [7.4. If your effort doesn't](#74-if-your-effort-doesnt)
  - [7.5. Conway's Law states](#75-conways-law-states)
  - [7.6. DevOps is really about](#76-devops-is-really-about)
  - [7.7. What is DevOps culture?](#77-what-is-devops-culture)
    - [7.7.1. We were taught the requisite skills as children](#771-we-were-taught-the-requisite-skills-as-children)
    - [7.7.2. Maintaining relationships is your most important skill](#772-maintaining-relationships-is-your-most-important-skill)
    - [7.7.3. Be quick... Be slow to...](#773-be-quick-be-slow-to)
    - [7.7.4. The pressures of social media](#774-the-pressures-of-social-media)
  - [7.8. How is DevOps related to the Agile?](#78-how-is-devops-related-to-the-agile)
  - [7.9. How do they differ?](#79-how-do-they-differ)
  - [7.10. Why?](#710-why)
  - [7.11. What are the principles of DevOps?](#711-what-are-the-principles-of-devops)
  - [7.12. Much of this is achieved](#712-much-of-this-is-achieved)
  - [7.13. What is Continuous Integration (CI)?](#713-what-is-continuous-integration-ci)
  - [7.14. How?](#714-how)
  - [7.15. CI best practices](#715-ci-best-practices)
    - [7.15.1. Utilize a Configuration Management System](#7151-utilize-a-configuration-management-system)
    - [7.15.2. Automate the build](#7152-automate-the-build)
    - [7.15.3. Employ one or more CI services/orchestrators](#7153-employ-one-or-more-ci-servicesorchestrators)
    - [7.15.4. Make builds self-testing](#7154-make-builds-self-testing)
    - [7.15.5. Never commit broken](#7155-never-commit-broken)
    - [7.15.6. Stakeholders are expected to pre-flight new code](#7156-stakeholders-are-expected-to-pre-flight-new-code)
    - [7.15.7. The CI service/orchestrator provides feedback](#7157-the-ci-serviceorchestrator-provides-feedback)
  - [7.16. What is Continuous Delivery?](#716-what-is-continuous-delivery)
    - [7.16.1. Extending Continuous Integration (CI)](#7161-extending-continuous-integration-ci)
    - [7.16.2. Consistency](#7162-consistency)
  - [7.17. But wait. What's a pipeline?](#717-but-wait-whats-a-pipeline)
  - [7.18. How is a pipeline manifested?](#718-how-is-a-pipeline-manifested)
  - [7.19. What underlines all of this?](#719-what-underlines-all-of-this)
  - [7.20. But really why do we automate err. code?](#720-but-really-why-do-we-automate-err-code)
    - [7.20.1. Why do I mention Larry Wall?](#7201-why-do-i-mention-larry-wall)
    - [7.20.2. Laziness](#7202-laziness)
    - [7.20.3. Impatience](#7203-impatience)
    - [7.20.4. Hubris](#7204-hubris)
    - [7.20.5. We automate for](#7205-we-automate-for)
  - [7.21. Monitoring](#721-monitoring)
    - [7.21.1. The _primary_ metric](#7211-the-_primary_-metric)
    - [7.21.2. An understanding of performance](#7212-an-understanding-of-performance)
    - [7.21.3. Establish a baseline performance](#7213-establish-a-baseline-performance)
    - [7.21.4. Set reaction thresholds](#7214-set-reaction-thresholds)
    - [7.21.5. Reacting](#7215-reacting)
    - [7.21.6. Gaps in CICD](#7216-gaps-in-cicd)
    - [7.21.7. Eliminating waste](#7217-eliminating-waste)
  - [7.22. Crawl, walk, run](#722-crawl-walk-run)
    - [7.22.1. Ultimately, DevOps is Goal](#7221-ultimately-devops-is-goal)
- [8. Reading list](#8-reading-list)
- [9. Now the hands-on part](#9-now-the-hands-on-part)
  - [9.1. Prerequisites](#91-prerequisites)
  - [9.2. Manual inspection](#92-manual-inspection)
  - [9.3. Shell configuration](#93-shell-configuration)
  - [9.4. Installing upfront dependencies](#94-installing-upfront-dependencies)
  - [9.5. OS X or Windows 11, install Docker Desktop](#95-os-x-or-windows-11-install-docker-desktop)
    - [9.5.1. On OSX install Docker Desktop](#951-on-osx-install-docker-desktop)
    - [9.5.2. On Windows install Docker Desktop](#952-on-windows-install-docker-desktop)
    - [9.5.3. On Arch Linux](#953-on-arch-linux)
  - [9.6. On OSX install iTerm2](#96-on-osx-install-iterm2)
- [10. Installing the software factory](#10-installing-the-software-factory)
  - [10.1. Ansible](#101-ansible)
    - [10.1.1. Installing Ansible](#1011-installing-ansible)
    - [10.1.2. On OSX, install the Xcode Command Line tools](#1012-on-osx-install-the-xcode-command-line-tools)
    - [10.1.3. On OSX, install HomeBrew](#1013-on-osx-install-homebrew)
    - [10.1.4. Install Ansible](#1014-install-ansible)
  - [10.2. Run the Ansible playbook](#102-run-the-ansible-playbook)
    - [10.2.1. Review the Ansible playbook](#1021-review-the-ansible-playbook)
    - [10.2.2. On OSX, enable nerd fonts in XTerm2](#1022-on-osx-enable-nerd-fonts-in-xterm2)
  - [10.3. Spin up the Factory](#103-spin-up-the-factory)
    - [10.3.1. The Makefile](#1031-the-makefile)

<!-- /TOC -->

# 7. DevOps unpacked

## 7.1. What is DevOps?

DevOps (a clipped compound of the words _development_ and _operations_) is a software development methodology with an emphasis on a reliable release pipeline, automation, and stronger collaboration across all stakeholders with the goal of delivery of value in close alignment with business objectives into the hands of users (i.e., production) more efficiently and effectively.

_Ops_ in DevOps gathers up every IT operation stakeholders (i.e., cybersecurity, testing, DB admin, infrastructure and operations practitioners -- essentially, any stakeholder not commonly thought of as directly part of the development team in the system development life cycle).

Yeah, that's the formal definition.

In the opening sentences of _Security Engineering: : A Guide to Building Dependable Distributed Systems — Third Edition_, author Ross Anderson defines what a security engineer is

> Security engineering is about building systems to remain dependable in the face of malice, error, or mischance. As a discipline, it focuses on the tools, processes, and methods needed to design, implement, and test complete systems, and to adapt existing systems as their environment evolve.

The words _security engineering_ could be replaced in the opening sentence with each one of the various stakeholders (e.g., development, quality assurance, technology operations).

The point I'm after is everyone is in it to collectively deliver dependable software.

Also, there is no need to overload the _DevOps_ term -- To _Dev wildcard (i.e., \*) Ops_ to include your pet interest(s), such as, _security_, _test_, _whatever_... to form _DevSecOps_, _DevTestOps_, _DevWhateverOps_... _DevOps_ has you covered.

## 7.2. What DevOps is not

About the tools.

![My Pillow Guy](./images/my_pillow_guy.png)

<sub>There are countless vendors out there, who want to sell you their crummy tool.</sub>

## 7.3. To succeed at DevOps you must

**Combine software development and information technology operations in the systems development life cycle** with **a focus on collaboration across the life cycle to deliver features, fixes, and updates frequently in close alignment with business objectives**.

If the effort cannot combine both Dev and Ops in collaboration with this focus the effort will most certainly fail.

## 7.4. If your effort doesn't

**grok (i.e, Understand intuitively) what DevOps is in practice** and have performed the **necessary analysis of the existing culture and a strategy for how to affect a change** the effort again will likely fail.

I say this because the culture is the largest influencer over the success of both Agile and DevOps and ultimately the path taken (i.e., plans made.)

## 7.5. Conway's Law states

> Any organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure.

From ["How Do Committees Invent?"](http://www.melconway.com/Home/Conways_Law.html)

Followed with

> Ways must be found to reward design managers for keeping their organizations lean and flexible.

This was written over 50 years ago.

If your communication structure is broke, so shall your systems be.

## 7.6. DevOps is really about

Providing the culture, methods and repeated practices to permit stakeholders to collaborate.

## 7.7. What is DevOps culture?

> **culture** noun \ _ˈkəl-chər_ \
> the set of shared attitudes, values, goals, and practices that characterizes an institution or organization

I love when a word means precisely what you need it to mean.

With the stakeholders sharing the same attitudes, values, goals, using the same tools, methods and repeated practices for their particular discipline you have **_DevOps Culture_**.

### 7.7.1. We were taught the requisite skills as children

![Paw Patrol](./images/paw_patrol.png)

### 7.7.2. Maintaining relationships is your most important skill

![Maintaining Relationships](./images/maintaining_relationships.png)

### 7.7.3. Be quick... Be slow to...

![Quick to slow](./images/quick_to_slow_to.png)

### 7.7.4. The pressures of social media

![Social Media](./images/social_media.png)

## 7.8. How is DevOps related to the Agile?

Agile Software Development is an umbrella term for a set of methods and practices based on the [values](http://www.agilealliance.org/agile101/the-agile-manifesto/) and [principles](http://www.agilealliance.org/agile101/12-principles-behind-the-agile-manifesto/) expressed in the Agile Manifesto.

For Agile, solutions evolve through collaboration between self-organizing, cross-functional teams utilizing the appropriate practices for their context.

DevOps builds on this.

## 7.9. How do they differ?

While DevOps extends Agile methods and practices by adding communication and collaboration between

- development,
- security,
- quality assurance, and
- technology operations

functionaries as stakeholders into the broader effort to ensure software systems are delivered in a reliable, low-risk manner.

## 7.10. Why?

In Agile Software Development, there is rarely an integration of these individuals outside the immediate application development team with members of technology operations (e.g., network engineers, administrators, testers, security engineers.)

## 7.11. What are the principles of DevOps?

As DevOps matures, several principles have emerged, namely the necessity for product teams to:

- Apply holistic thinking to solve problems,
- Develop and test against production-like environments,
- Deploy with repeatable and reliable processes,
- Remove the drudgery and uncertainty through automation,
- Validate and monitor operational quality, and
- Provide rapid, automated feedback to the stakeholders

## 7.12. Much of this is achieved

Through the repeated practices of Continuous Integration (CI) and Continuous Delivery (CD) often conflated into simply "CI/CD" or "CICD".

WARNING: After tools, CICD is the next (**albeit mistakenly**) thing thought to be the totality of DevOps.

## 7.13. What is Continuous Integration (CI)?

It is a repeated Agile software development practice lifted specifically from Extreme programming, where members of a development team frequently integrate their work to detect integration issues as quickly as possible thereby shifting discovery of issues "left" (i.e., early) in the software release.

## 7.14. How?

Each integration is orchestrated through a CI service/orchestrator (e.g., Jenkins CI, Drone CI, GitLab Runners, Concourse CI) that essentially assembles a build, runs unit and integration tests every time a predetermined trigger has been met; and then reports with immediate feedback.

## 7.15. CI best practices

### 7.15.1. Utilize a Configuration Management System

For the software's source code, where the mainline (i.e., master branch) is the most recent working version, past releases held in branches, and new features not yet merged into the mainline branch worked in their own branches.

### 7.15.2. Automate the build

By accompanying build automation (e.g., Gradle, Apache Maven, Make) alongside the source code.

### 7.15.3. Employ one or more CI services/orchestrators

To perform source code analysis via automating formal code inspection and assessment.

### 7.15.4. Make builds self-testing

In other words, ingrain testing by including unit and integration tests (e.g., Spock, JUnit, Mockito, SOAPUI, go package _Testing_) with the source code to be executed by the build automation to be executed by the CI service.

### 7.15.5. Never commit broken

Or untested source code to the CMS mainline or otherwise risk breaking a build.

### 7.15.6. Stakeholders are expected to pre-flight new code

Prior to committing source code in their own workspace.

### 7.15.7. The CI service/orchestrator provides feedback

On the success or fail of a build integration to all its stakeholders.

## 7.16. What is Continuous Delivery?

It is a repeated software development practice of providing a rapid, reliable, low-risk product delivery achieved through automating all facets of building, testing, and deploying software.

### 7.16.1. Extending Continuous Integration (CI)

With additional stages/steps aimed to provide ongoing validation that a newly assembled software build meets all desired requirements and thereby is releasable.

### 7.16.2. Consistency

Is achieved through delivering applications into production via individual repeatable pipelines of ingrained system configuration management and testing

## 7.17. But wait. What's a pipeline?

A pipeline automates the various stages/steps (e.g., Static Application Security Testing (SAST), build, unit testing, Dynamic Application Security Testing (DAST), secure configuration acceptance compliance, integration, function and non-functional testing, delivery, and deployment) to enforce quality conformance.

## 7.18. How is a pipeline manifested?

Each delivery pipeline is manifested as **Pipeline as Code** (i.e., software automation) accompanying the application's source code in its version control repository.

## 7.19. What underlines all of this?

I and the community of practice argue DevOps will struggle without ubiquitous access to shared pools of software configurable system resources and higher-level services that can be rapidly provisioned (i.e., cloud).

Although, it is actually possible to [DevOps on mainframes](https://www.youtube.com/watch?v=eMS97X5ZTGc) The video is in the contect of continuous delivery, but read between the lines.

## 7.20. But really why do we automate err. code?

In 2001, I think Larry Wall in his 1st edition of _Programming Perl_ book put it best with "We will encourage you to develop the three great virtues of a programmer:

laziness,

impatience, and

hubris."

The second edition of the same book provided definitions for these terms

### 7.20.1. Why do I mention Larry Wall?

Well...

Let me explain.

### 7.20.2. Laziness

> The quality that makes you go to great effort to reduce overall energy expenditure. It makes you write labor-saving programs that other people will find useful, and document what you wrote so you don't have to answer so many questions about it. Hence, the first great virtue of a programmer.\_ (p.609)

### 7.20.3. Impatience

> The anger you feel when the computer is being lazy. This makes you write programs that don't just react to your needs, but actually anticipate them. Or at least pretend to. Hence, the second great virtue of a programmer.\_ (p.608)

### 7.20.4. Hubris

> Excessive pride, the sort of thing Zeus zaps you for. Also, the quality that makes you write (and maintain) programs that other people won't want to say bad things about. Hence, the third great virtue of a programmer.\_ (p.607)

### 7.20.5. We automate for

- Faster, coordinated, repeatable, and therefore more reliable deployments.
- Discover bugs sooner. Shifting their discovery left in the process.
- To accelerates the feedback loop between Dev and Ops (Again, Ops is everyone not typically considered part of the development team.)
- Reduce tribal knowledge, where one group or person holds the keys to how things get done. Yep, this is about making us all replaceable.
- Reduce shadow IT (i.e., hardware or software within an enterprise that is not supported by IT. Just waiting for its day to explode.)

## 7.21. Monitoring

Once deployed, the work is done, right?

So, that improvements can be gauged and anomalies detected.A development team's work is not complete once a product leaves CICD and enters production; especially, under DevOps where the development team includes members of ops (e.g., security and technology operations).

### 7.21.1. The _primary_ metric

Is working software, but this is not the only, measurement. The key to successful DevOps is knowing how well the methodology and the software it produces are performing. Is the software truely dependable?

### 7.21.2. An understanding of performance

Is achieved by collecting and analyzing data produced by environments used for CICD and production.

### 7.21.3. Establish a baseline performance

So, that improvements can be gauged and anomalies detected.

### 7.21.4. Set reaction thresholds

To formulate and prioritize reactions weighting factors, such as, the frequency at which an anomaly arises and who is impacted.

### 7.21.5. Reacting

Could be as simple as operations instructing users through training to not do something that triggers the anomaly, or more ideally, result in an issue being entered into the product's backlog culminating in the development team delivering a fix into production.

### 7.21.6. Gaps in CICD

Are surfaces through monitoring resulting in for example additional testing for an issue discovered in prodcuction.

Yep. News flash. DevOps will not entirely stop all bugs or vulnerabilities from making it into production, but this was never the point.

### 7.21.7. Eliminating waste

Through re-scoping of requirements, re-prioritizing of a backlog, or the deprecation of unused features. Again, all surfaced through monitoring.

## 7.22. Crawl, walk, run

### 7.22.1. Ultimately, DevOps is Goal

- With DevOps one does not simply hit the ground running.
- One must first crawl, walk and then ultimately run as you embrace the necessary culture change, methods, and repeated practices.
- Collaboration and automation are expected to continually improve so to achieve more frequent and more reliable releases.

# 8. Reading list

**AntiPatterns: Refactoring Software, Architectures, and Projects in Crisis**
William J. Brown, Raphael C. Malveau, Hays W. "Skip" McCormick, and Thomas J. Mowbray
ISBN: 978-0-471-19713-3
Apr 1998

**Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation (Addison-Wesley Signature Series (Fowler))**
David Farley and Jez Humble
ISBN-13: 978-0321601919
August 2010

**The DevOps Handbook: How to Create World-Class Agility, Reliability, and Security in Technology Organizations**
Gene Kim Jez Humble, Patrick Debois, and John Willis
ISBN-13: 978-1942788003
October 2016

**Accelerate: The Science of Lean Software and DevOps: Building and Scaling High Performing Technology Organizations**
Nicole Forsgren PhD, Jez Humble, and Gene Kim
ISBN-13: 978-1942788331
March 27, 2018

**Site Reliability Engineering: How Google Runs Production Systems 1st Edition**
Betsy Beyer, Chris Jones, Jennifer Petoff, and Niall Richard Murphy
ISBN-13: 978-1491929124
April 16, 2016
Also, available online at https://landing.google.com/sre/book/index.html

**Release It!: Design and Deploy Production-Ready Software 2nd Edition**
Michael T. Nygard
ISBN-13: 978-1680502398
January 18, 2018

**The SPEED of TRUST: The One Thing That Changes Everything**
Stephen M .R. Covey
ISBN-13: 978-1416549000
February 5, 2008
The gist of the book can be found at SlideShare https://www.slideshare.net/nileshchamoli/the-speed-of-trust-13205957

**RELATIONSHIP TRUST: The 13 Behaviors of High-Trust Leaders Mini Session**
Franklin Covey Co.
https://archive.franklincovey.com/facilitator/minisessions/handouts/13_Behaviors_MiniSession_Handout.pdf

**How to Deal With Difficult People**
Ujjwal Sinha
Oct 25, 2014
The SlideShare can be found here https://www.slideshare.net/abhiujjwal/how-2-deal-wid-diiclt-ppl

**Leadership Secrets of the Rouge Warrior: A Commando's Guide to Success**
Richard Marcinko w/ John Weisman
ISBN-13: 978-0671545154
June 1, 1996

**Security Engineering: A Guide To Building Dependable Distributed Systems**
Ross Anderson
ISBN-13: 978-0470068526
April 14, 2008
The second edition of this book can be downloaded in whole from https://www.cl.cam.ac.uk/~rja14/book.html and Mr Anderson has released chapters from his 3rd edition under development.

**How Do Committees Invent?**
Melvin E. Conway
Copyright 1968, F. D. Thompson Publications, Inc.
http://www.melconway.com/Home/Conways_Law.html

**The Pragmatic Programmer: Your Journey To Mastery, 20th Anniversary Edition (2nd Edition)**
David Thomas and Andrew Hunt
ISBN-13: 978-0135957059
September 23, 2019

# 9. Now the hands-on part

## 9.1. Prerequisites

The supported host operating systems for this class are OSX, Windows 11 and Arch Linux. By "host operating system", I mean the computer you will use to work the class.

## 9.2. Manual inspection

It's a good idea to inspect the install scripts from projects you don't yet know. You can do that now by tromping around the projet on GitHub. The project makes use of a Makefile, several Bash scripts, Vagrant and Ansible code. Looking through everything before you run it. If you dork up your host this was never my intention, but I've made every effort to prevent this from happening.

## 9.3. Shell configuration

The class automation will configure Bash, Zsh and [fish](https://github.com/neovim/neovim) shells, as well as [neovim](https://github.com/neovim/neovim) (nvim). A Unix shell is a command-line iterpreter, a command-line interface for the Unix or Unix-like operating systems, such as Linux. The shell exists in a terminal emulator. In this course we will either be [iTerm2](https://iterm2.com/) for OSX or Arch Linux' terminal interface.

If you are on OSX and already have iTerm2 installed open a terminal window or use OSX built-in Terminal application by searching for "Terminal".

If you have spent considerable time configuring your chosen shell, neovim editor, etc it is advisable to back up your configuration by peforming the following in the shell:

**NOTE**

- This class will link to an application, tool, library, etc's canonical git repository whenever possible.
- This class makes use of **NOTE** sections to call out things that are important to know or to drop a few tidbits. Reading these notes may save you some aggravation.

```sh
cp ~/.bash_profile ~/.bash_profile.back
cp ~.profile ~.profile.back
cp ~/.zshrc ~/.zshrc.back
cp ~/.zshenv ~/.zshenv.back
cp ~/.zprofile ~/.zprofile.back
cp ~/.zlogin ~/.zlogin.back
cp ~/.config/fish/config.fish ~/.config/fish/config.fish.back
cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.back
cp ~/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json.back
```

On or more of the above commands may fail if you don't have the files on your host. If you are sure you typed the command correctly you can ignore the error

Now, we're going to to reset our configuration by performing the following

```sh
rm ~/.bash_profile ~/.zshrc ~/.zshenv ~/.zprofile ~/.zlogin ~/.config/fish/config.fish ~/.config/nvim/init.vim ~/.config/nvim/coc-settings.json
```

## 9.4. Installing upfront dependencies

You will need to install a number of upfront dependencies.

## 9.5. OS X or Windows 11, install Docker Desktop

If your host (e.g., your laptop, personal computer) is running Windows 10 or OSX you will need to install Docker Desktop. If you're using Arch Linux, the Ansible automation will take care of installing Docker for you and you can skip ahead to installing Ansible. If you are using a version of Linux other than Arch then what's wrong with you? I'm kidding. You can use the Vagrant to execute the factory.

This class will use Docker and so Docker Desktop must be installed and configured.

### 9.5.1. On OSX install Docker Desktop

If you're on an OSX host perform the following:

1. Download https://www.docker.com/products/docker-desktop
2. Drag the Docker app to your Application folder.
3. Find the Docker app in your applications folder and click to start the application.
4. You will need to verify that you want to trust the application by clicking `Open`.
5. The Docker Engine, actually a virtual machine (VM), will take sometime to start. You will then be asked to deny or accept `com.docker.backend` from accepting incoming network connections. Click `Allow`.
6. Find docker icon on the right side of your Apple menu bar and click and then select `preferences` from the menu.
7. In the `docker` window that opens, select the gear icon in the upper-right portion of the window.
8. Under `General` make sure `Start Docker Desktop when you log in` is checked off otherwise you will need to start docker everytime you restart your host.
9. Then select `Resources` on the left-hand side of the window.
10. As Docker runs its containers in a virtual machine, you will need to give this VM more processing power and host memory to run heavier container load. What you give the Docker Desktop VM is dependent on two factors the resources your host can spare and the load the class containers will place on your host. I'd advise trying 8 CPUs and 12 GBs of memory and scale as you see fit.
11. Click `Apply and Restart` to restart the Docker Desktop VM. The VM will take some amount of time to restart. The containers on the back of the whale icon (Moby Dock) will cycle the Apple Menu Bar will cycle until Docker is ready.

### 9.5.2. On Windows install Docker Desktop

To be completed, but until such time make sure to select the default option to install the WSL2 components is selected.

Skip ahead to installing the software factory.

### 9.5.3. On Arch Linux

Docker will be installed for you via the Ansible automation. More on Ansible later.

## 9.6. On OSX install iTerm2

If your using an OSX host, you can use Apple's default Terminal app for command line terminal, but I'd advise you to install the superior iTerm2.

Perform the following tasks:

1. Download the latest release from

   https://iterm2.com/downloads/stable/latest

2. Find the iTerm release zip file in your Downloads folder and double click.
3. Drag the iTerm app to your Application folder to install.
4. You will need to verify that you want to trust the application by clicking `Open`.
5. Use iTerm2 to perform the remaining command line tasks for this class.

# 10. Installing the software factory

This class uses a software factory hosted on a Kubernetes cluster. To spin up the k8s cluster you will need to perform the following tasks in the command line.

## 10.1. Ansible

The class uses [Ansible](https://github.com/ansible/ansible) to install operating systems dependencies necessary for the class.

Ansible is a "configuration management" tool that automates software provisioning, configuration management and application deployment, two core repeated practices in DevOps, so for the class Ansible addresses this concern in the configuration of either your host operating system or a VM, if you've chosen to execute the class from a Vagrant.

Ansible was open-sourced and then later subsumed by Red Hat.

There are other notable open-source "configuration management" tools, such as [Chef](https://github.com/chef/chef) and [Puppet](https://github.com/chef/chef). Further, still there are others, such as [BOSH](https://github.com/cloudfoundry/bosh) and [Salt](https://github.com/saltstack/salt), but they hold little or no community of practice or market share.

In his seminal essay, "The Cathedral and the Bazaar", Eric S. Raymond states

> while coding remains an essentially solitary activity, the really great hacks
> come from harnessing the attention and brainpower of entire communities
>
> You want to leverage the work of vibrate community and not some back water
> effort.

In Ansible, one defines [playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) to declaratively state desired configuration of a host. Yes, utilizing declarative programming vice imperative programming. With declarative programming your code essentially describes what you want, but not how to get what you want. With imperative programming, ones' code states what you want to happen step-by-step. The class will makes use of Ansible, Kubernetes resource files and Helm charts to declare the desired end-state. These will be unpacked later in the class material. The truth is the two are often intermixed. Your Ansible playbooks can be a mix of declarative and imperative programming. One strives for the former rather than the later.

Each Ansible playbook is written in a [YAML](https://yaml.org/)-based DSL (domain specific language) following the [ansible-playbook schema](https://json.schemastore.org/ansible-playbook.json) enumerating all the tasks to be performed.

The playbooks for this class are located in the [ansible/](./ansible/) project sub-folder

```
ansible/
├── common.yaml
├── files
│   ├── coc-settings.json
│   └── init.vim
├── go.yaml
├── inspec.yaml
├── inventory.yaml
├── main.yaml
├── neovim.yaml
├── package.json
├── pyenv.yaml
├── ruby.yaml
└── sonar-scanner-cli.yaml
```

Each playbook is responsible for a unit of configuration. [ansible/files/](./ansible/files/) contains a number of files copied into the userspace to configure the [neovim](https://github.com/neovim/neovim) editor.

It also possible to collect these tasks into a collection referred to as a `role`. This class presently doesn't make use of roles.

### 10.1.1. Installing Ansible

The following sub-sections detail how to install Ansible. Skip to the section that applies to your host.

If your host is running

- OSX drop to [Installing Xcode Command Line Tools.
- Windows drop to (TODO: complete.)
- Linux drop to (TODO: complete.)

### 10.1.2. On OSX, install the Xcode Command Line tools

I prefer to install the Xcode Command Line tools myself, but you could skip this step and have HomeBrew install it for you.

1. In iTerm2 enter the following into the commmand line.

   ```sh
   xcode-select --install
   ```

   It is possible your host may already have the Xcode Command Line Tools installed and will be immediately told so if this is the case skip to the next section

2. A dialog will pop on the screen asking if you'd like to install the command line developer tools. Click `Install`.
3. You will then be presented a License Agreement. After consulting your lawyer, click `Agree`.
4. Wait fo the download and install to complete, then click `Done`.

### 10.1.3. On OSX, install HomeBrew

Homebrew is as the project refers to itself, "The Missing Package Manager for macOS." These days the project also tacks on "(or Linux)". Package managers A package manager automates the process of installing, upgrading, configuring, and removing binaries from an operating system.

I could of had the Ansible playbook install this dependency, but I'd rather you become familiar with the fact there is in fact a community driven package manager for OSX.

Install brew by performing the following:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Success resembles

```
Password:
==> This script will install:
/usr/local/bin/brew
/usr/local/share/doc/homebrew
/usr/local/share/man/man1/brew.1
/usr/local/share/zsh/site-functions/_brew
/usr/local/etc/bash_completion.d/brew
/usr/local/Homebrew

Press RETURN to continue or any other key to abort
==> /usr/bin/sudo /usr/sbin/chown -R nemonik:admin /usr/local/Homebrew
==> Downloading and installing Homebrew...
remote: Enumerating objects: 20, done.
remote: Counting objects: 100% (8/8), done.
remote: Total 20 (delta 8), reused 8 (delta 8), pack-reused 12
Unpacking objects: 100% (20/20), 4.12 KiB | 175.00 KiB/s, done.
From https://github.com/Homebrew/brew
 * [new branch]          dependabot/bundler/Library/Homebrew/sorbet-0.5.6442 -> origin/dependabot/bundler/Library/Homebrew/sorbet-0.5.6442
Updating files: 100% (2703/2703), done.
HEAD is now at 63ed6da2c Merge pull request #11564 from cnnrmnn/new-maintainer-checklist-typo
Updated 2 taps (homebrew/core and homebrew/cask).
==> Installation successful!

==> Homebrew has enabled anonymous aggregate formulae and cask analytics.
Read the analytics documentation (and how to opt-out) here:
  https://docs.brew.sh/Analytics
No analytics data has been sent yet (or will be during this `install` run).

==> Homebrew is run entirely by unpaid volunteers. Please consider donating:
  https://github.com/Homebrew/brew#donations

==> Next steps:
- Run `brew help` to get started
- Further documentation:
    https://docs.brew.sh
```

### 10.1.4. Install Ansible

Ansible is based on [Python](https://www.python.org/) ans distributed as a Python module that you can install by [pip](https://pip.pypa.io). Pip refers to itself as "the package installer for Python". There are [others](https://packaging.python.org/guides/tool-recommendations/), but most everyone uses pip.

In the command line perform the following task:

Type the following

```sh
python3 -m pip install --user ansible
```

This will install the ansible module into the Python user install directory for your platform. Typically into the `.local/` sub-folder of the user's home directory.

Output will resemble

```
⋊> ~ python3 -m pip install --user ansible
Collecting ansible
  Downloading ansible-4.2.0.tar.gz (35.0 MB)
     |████████████████████████████████| 35.0 MB 6.0 MB/s
Collecting ansible-core<2.12,>=2.11.2
  Downloading ansible-core-2.11.2.tar.gz (7.1 MB)
     |████████████████████████████████| 7.1 MB 2.1 MB/s
Collecting jinja2
  Downloading Jinja2-3.0.1-py3-none-any.whl (133 kB)
     |████████████████████████████████| 133 kB 13.8 MB/s
Collecting PyYAML
  Downloading PyYAML-5.4.1-cp39-cp39-manylinux1_x86_64.whl (630 kB)
     |████████████████████████████████| 630 kB 2.8 MB/s
Collecting cryptography
  Downloading cryptography-3.4.7-cp36-abi3-manylinux2014_x86_64.whl (3.2 MB)
     |████████████████████████████████| 3.2 MB 3.1 MB/s
Collecting packaging
  Downloading packaging-21.0-py3-none-any.whl (40 kB)
     |████████████████████████████████| 40 kB 9.6 MB/s
Collecting resolvelib<0.6.0,>=0.5.3
  Downloading resolvelib-0.5.4-py2.py3-none-any.whl (12 kB)
Collecting cffi>=1.12
  Downloading cffi-1.14.5-cp39-cp39-manylinux1_x86_64.whl (406 kB)
     |████████████████████████████████| 406 kB 4.0 MB/s
Collecting pycparser
  Downloading pycparser-2.20-py2.py3-none-any.whl (112 kB)
     |████████████████████████████████| 112 kB 3.0 MB/s
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.0.1-cp39-cp39-manylinux2010_x86_64.whl (30 kB)
Collecting pyparsing>=2.0.2
  Downloading pyparsing-2.4.7-py2.py3-none-any.whl (67 kB)
     |████████████████████████████████| 67 kB 3.4 MB/s
Using legacy 'setup.py install' for ansible, since package 'wheel' is not installed.
Using legacy 'setup.py install' for ansible-core, since package 'wheel' is not installed.
Installing collected packages: pycparser, pyparsing, MarkupSafe, cffi, resolvelib, PyYAML, packaging, jinja2, cryptography, ansible-core, ansible
    Running setup.py install for ansible-core ... done
    Running setup.py install for ansible ... done
Successfully installed MarkupSafe-2.0.1 PyYAML-5.4.1 ansible-4.2.0 ansible-core-2.11.2 cffi-1.14.5 cryptography-3.4.7 jinja2-3.0.1 packaging-21.0 pycparser-2.20 pyparsing-2.4.7 resolvelib-0.5.4
```

In order to use the paramiko connection plugin or modules that require paramiko, install paramiko

```sh
python3 -m pip3 install --user paramiko
```

Output will resemble

```
⋊> ~ python3 -m pip install --user paramiko
Collecting paramiko
  Downloading paramiko-2.7.2-py2.py3-none-any.whl (206 kB)
     |████████████████████████████████| 206 kB 1.7 MB/s
Collecting bcrypt>=3.1.3
  Downloading bcrypt-3.2.0-cp36-abi3-manylinux2010_x86_64.whl (63 kB)
     |████████████████████████████████| 63 kB 1.5 MB/s
Requirement already satisfied: cryptography>=2.5 in /home/nemonik/.local/lib/python3.9/site-packages (from paramiko) (3.4.7)
Collecting pynacl>=1.0.1
  Downloading PyNaCl-1.4.0-cp35-abi3-manylinux1_x86_64.whl (961 kB)
     |████████████████████████████████| 961 kB 4.2 MB/s
Requirement already satisfied: cffi>=1.1 in /home/nemonik/.local/lib/python3.9/site-packages (from bcrypt>=3.1.3->paramiko) (1.14.5)
Collecting six>=1.4.1
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Requirement already satisfied: pycparser in /home/nemonik/.local/lib/python3.9/site-packages (from cffi>=1.1->bcrypt>=3.1.3->paramiko) (2.20)
Installing collected packages: six, pynacl, bcrypt, paramiko
Successfully installed bcrypt-3.2.0 paramiko-2.7.2 pynacl-1.4.0 six-1.16.0
```

Ansible is now installed in your home directory in `$HOME/.local/bin` path, where is `$HOME` is an environment variable holding the path to your home directory.

But if you enter the following into the shell

```sh
which ansible-playbook
```

the output will likely be

```
ansible-playbook not found
```

The [`which`](https://linux.die.net/man/1/which) command will attempt to locate a program file in the user's path.

If you are using `bash` perform the following:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

If your shell is `zsh`:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

If you're using `fish`:

```sh
echo 'set -U fish_user_paths $HOME/.local/bin $fish_user_paths' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

to add the Ansible executables to your path. The `PATH` environment variable is a list of directories that your shell searches through when you enter a command.

Not that we updated our `PATH` and sourced our shell configuratiion thereby updating our present shell we can verify `ansible` has been installed via

```sh
ansible-playbook --version
```

Output will resemble

```
⋊> ~ ansible-playbook --version
ansible-playbook [core 2.11.2]
  config file = None
  configured module search path = ['/home/nemonik/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/nemonik/.local/lib/python3.9/site-packages/ansible
  ansible collection location = /home/nemonik/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/mjwalnemonik/.local/bin/ansible-playbook
  python version = 3.9.5 (default, Jul  5 2021, 10:39:40) [GCC 11.1.0]
  jinja version = 3.0.1
  libyaml = True
```

Let's test to see if Ansible works on our host by executing

```sh
ansible localhost -m ping
```

Output should resemble

```
[WARNING]: No inventory was parsed, only implicit localhost is available
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

The fact that `ping` returns `pong` indicates Ansible has been installed correctly.

You will need to perform the following in the shell to add [community.general](https://galaxy.ansible.com/community/general) Ansible module from [Ansible Galaxy](https://galaxy.ansible.com/), Ansible’s official hub for sharing Ansible content.

For example, on an OSX host, we'll need this to install `brew` packages and for Arch Linux we'll need this to install operating systems package via [pacman](https://wiki.archlinux.org/title/Pacman) package manager.

```sh
ansible-galaxy collection install community.general
```

Successful output should resemble

```
⋊> ~ ansible-galaxy collection install community.general
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Downloading https://galaxy.ansible.com/download/community-general-3.3.1.tar.gz to /home/nemonik/.ansible/tmp/ansible-local-1333943849hwygv/tmplq_el1ud/community-general-3.3.1-d99hf7_o
Installing 'community.general:3.3.1' to '/home/nemonik/.ansible/collections/ansible_collections/community/general'
community.general:3.3.1 was installed successfully
```

## 10.2. Run the Ansible playbook

The rest of the class will require a number of operating system dependencies be installed. We will accomplish the via executing the [ansible/main.yaml](ansible/main.yaml) playbook.

First we will need to [git clone](https://git-scm.com/docs/git-clone) the class repository by performing the following in your shell

```sh
mkdir -p $HOME/Development/workspace
cd $HOME/Development/workspace
git clone https://github.com/nemonik/hands-on-DevOps-gen2.git
```

Enter the project's [ansible/](./ansible) sub-folder

```sh
cd ansible
```

### 10.2.1. Review the Ansible playbook

If you haven't reviewed the playbook, now is a good time to do so.

The `ansible-playbook` command will execute a series of playbooks across an inventory of hosts. For the class we have just one host and this is `localhost`, your host.

The contents of `inventory.yaml` file is in `ansible` folder written in [YAML](https://yaml.org/) following [Ansible Inventory shema](https://json.schemastore.org/ansible-inventory.json) and resembles

```
all:
  children:
    factory:
      hosts:
        localhost:
          ansible_connection: local
          ansible_host: localhost
          ansible_python_interpreter: /usr/bin/python3
      vars:
        default_delay: 10
        default_retries: 60
        ruby_version: 3.0.1
        supported_host_os:
          - MacOSX
          - Archlinux
    ungrouped: {}
```

Where

- `factory` is a group name used in classifying hosts.
- `localhost` is the alias for your host.
- `ansible_host`, `ansible_connection` and `ansible_python_interpreter` are behavioral inventory parameters used to control haw Ansible interacts with your host.
  - `ansible_host` describes the name of the host to connect to. This parameter is redundant in this instance.
  - `ansible_connection` describes the connection type used to connect to the host. In our case this set to `local`. Another type would be `ssh` if the host was remote.
  - `ansible_python_interpreter` describes the target host's python path. Python is "batteries included" on OSX and will be found on Arch Linux.
- `vars` describes a number of variables uses across the playbooks: `default_delay`, `default_retries`, `ruby_version` and `supported_host_os`.
  - `default_delay` sets the number of seconds to delay between retries.
  - `default_retries` sets the number times a task will be retried before Ansible gives up.
  - `ruby_version` sets the ruby version to install, and
  - `supported_host_os` is a list of supported operating systems.

A playbook is composed of one or more _plays_ in an ordered list, where plays are executed in order from top to bottom. Most Ansible modules (also referred to as “task plugins” or “library plugins”) check whether the desired state has already been achieved and the playbook will move on without performing any actions once the desired state has been achieved. This is refered to as being _idempotent_.

Let's look at the [ansible/main.yaml](./ansible/main.yaml) playbook.

```
---
- name: Install factory dependencies
  hosts: factory
  tasks:
    - name: Echo ansible distribution
      ansible.builtin.debug:
        msg: "{{ inventory_hostname }} host is running {{ ansible_distribution }}:{{ ansible_distribution_release }} with an IP address if {{ ansible_default_ipv4.address }}"

    - name: Fail if OS is not MacOSX or ArchLinux
      ansible.builtin.fail:
        msg: "{{ ansible_distribution }} - {{ ansible_distribution_release }} is not MacOSX or ArchLinux"
      when: ansible_distribution not in supported_host_os
```

The lines above name the playbook and state the group name (in this case `factory` correlated with the inventory) this playbook will be applied to. Followed by two tasks that will be executed.

The first task, `ansible.builtin.debug` is used for debugging purposes. The second, `ansible.builtin.fail` tests whether or not the host is supported.

We can retrieve the documentation for both in the shell via using the [`ansible-doc`](https://docs.ansible.com/ansible/latest/cli/ansible-doc.html) command. For example, if we enter

```sh
ansible-doc ansible.builtin.debug
```

into the shell, it will return

```
> ANSIBLE.BUILTIN.DEBUG    (/Users/nemonik/.local/lib/python3.9/site-packages/ansible/modules/debug.py)

        This module prints statements during execution and can be useful for debugging variables or
        expressions without necessarily halting the playbook. Useful for debugging together with the
        'when:' directive. This module is also supported for Windows targets.

  * note: This module has a corresponding action plugin.

OPTIONS (= is mandatory):

- msg
        The customized message that is printed. If omitted, prints a generic message.
        [Default: Hello world!]
        type: str

- var
        A variable name to debug.
        Mutually exclusive with the `msg' option.
        Be aware that this option already runs in Jinja2 context and has an implicit `{{ }}' wrapping,
        so you should not be using Jinja2 delimiters unless you are looking for double interpolation.
        [Default: (null)]
        type: str

- verbosity
        A number that controls when the debug is run, if you set to 3 it will only run debug when -vvv
        or above.
        [Default: 0]
        type: int
        version_added: 2.1
        version_added_collection: ansible.builtin


NOTES:
      * This module is also supported for Windows targets.


SEE ALSO:
      * Module ansible.builtin.assert
           The official documentation on the ansible.builtin.assert module.
           https://docs.ansible.com/ansible/2.11/modules/ansible.builtin.assert_module.html
      * Module ansible.builtin.fail
           The official documentation on the ansible.builtin.fail module.
           https://docs.ansible.com/ansible/2.11/modules/ansible.builtin.fail_module.html


AUTHOR: Dag Wieers (@dagwieers), Michael DeHaan

VERSION_ADDED_COLLECTION: ansible.builtin

EXAMPLES:

- name: Print the gateway for each host when defined
  ansible.builtin.debug:
    msg: System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}
  when: ansible_default_ipv4.gateway is defined

- name: Get uptime information
  ansible.builtin.shell: /usr/bin/uptime
  register: result

- name: Print return information from the previous task
  ansible.builtin.debug:
    var: result
    verbosity: 2

- name: Display all variables/facts known for a host
  ansible.builtin.debug:
    var: hostvars[inventory_hostname]
    verbosity: 4

- name: Prints two lines of messages, but only if there is an environment value set
  ansible.builtin.debug:
    msg:
    - "Provisioning based on YOUR_KEY which is: {{ lookup('env', 'YOUR_KEY') }}"
    - "These servers were built using the password of '{{ password_used }}'. Please retain this for later use."
```

And the playbook continues on to importing and executing each of the following playbooks

```ansible
- name: Ensure common dependencies are installed
  ansible.builtin.import_playbook: common.yaml

- name: Ensure pyenv is installed and configured
  ansible.builtin.import_playbook: pyenv.yaml

- name: Ensure Go is installed and configured
  ansible.builtin.import_playbook: go.yaml

- name: Ensure sonar-scanner cli is installed and configured
  ansible.builtin.import_playbook: sonar-scanner-cli.yaml

- name: Ensure rvm and ruby {{ ruby_version }} is installed
  ansible.builtin.import_playbook: ruby.yaml

- name: Ensure InSpec is installed
  ansible.builtin.import_playbook: inspec.yaml

- name: Ensure neovim is installed and configured
  ansible.builtin.import_playbook: neovim.yaml
```

I'd encourage you to review them all, but lets look at a portion of the first to be imported and executed, the [ansible/common.yaml](./ansible/common.yaml) playbook

```ansible
---
- name: Ensure common dependencies are installed
  hosts: factory
```

Again, the playbook is named and states the group name this playbook will be applied to.

```ansible
  tasks:
    - name: Set fact for $HOME
      ansible.builtin.set_fact:
        HOME: "{{ lookup('env', 'HOME') }}"
```

Followed in by executing a number of tasks. The first being to create a fact to hold the HOME environment variable.

```ansible
    - name: When MacOSX ensure Homebrew packages are installed
      block:
        - name: Update homebrew and upgrade all packages
          community.general.homebrew:
            update_homebrew: yes
            upgrade_all: yes

        - name: Check if /usr/local/Cellar/bash-completion exists
          ansible.builtin.stat:
            path: /usr/local/Cellar/bash-completion
          register: bash_completion

        - name: Ensure bash-completion is not installed, so bash-completion@2 can be installed
          ansible.builtin.shell: brew unlink bash-completion
          when: bash_completion.stat.exists

        - name: Ensure HomeBrew packages are installed
          community.general.homebrew:
            name:
              - bash
              - bash-completion@2
              - zsh
              - zsh-completion
              - fish
              - vim
              - nano
              - pwgen
              - openssl
              - watch
              - gettext
              - k3d
              - helm
              - curl
              - wget
              - git-secrets
              - tmux
              - yamllint
              - jq
              - tree
              - htop
              - pyenv
            state: latest
          retries: "{{ default_retries }}"
          delay: "{{ default_delay }}"
          register: result
          until: result is succeeded

        - name: Get HOMEBREW_PREFIX
          block:
            - name: Execute brew --prefix
              ansible.builtin.shell: brew --prefix
              register: brew_prefix

            - name: Create brew_fact with stdout of of prior command
              ansible.builtin.set_fact:
                HOMEBREW_PREFIX: "{{ brew_prefix.stdout }}"
      when: ( ansible_distribution == 'MacOSX' )
```

First, the `when` condition will be evaluated to determine if the host to be "ansible-ized" is running OSX before Ansible runs each of the tasks in the block.

The block collects the following tasks:

1. `community.general.homebrew` is used to update the host's installed packages,
2. `ansible.builtin.stat` checks and holds in a register where or not the `/usr/local/Cellar/bash-completion` path exists on the host.
3. `ansible.builtin.shell` executes `brew` to unlink `bash-completion` thereby ensuring the the wrong `bash-completions` package is not installed, but only if the path had been found.
4. `community.general.homebrew` tries repeatedly to install a list of HomeBrew packages until they're installed or the maximum number of retries are reached.
5. A sub-block ends out the run with
   1. `ansible.builtin.shell` executing `brew --prefix` and storing the result in a register
   2. `ansible.builtin.set_fact` is used to hold the standard output (stdout) of `brew--prefix` command in a Ansible fact, `HOMEBREW_PREFIX`.

The [ansible/common.yaml](./ansible/common.yaml) playbook continues until completion and then you are returned to the [ansible/main.yaml](./ansible/main.yaml) to execute the next playbook. I'd encourage you to review each.

If your on LinkedIn or search many of the job boards you'll find many employers equate infrastructure-as-code as DevOps. Infrastructure-as-code is a DevOps methodology but not the entirety of DevOps.

Now that we've reviewed the playbook lets execute it via the Make target `install-dependencies` in the root of the project in our shell

```sh
cd ..
make install-dependencies
```

I'll explained what Make and a target is in subsequent section. As the output is a bit too large to capture here, I've only capture the last few lines of the output below. I will resemble

```
<localhost> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /Users/nemonik/.ansible/tmp `"&& mkdir "` echo /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439 `" && echo ansible-tmp-1625702462.673148-73856-255765969896439="` echo /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439 `" ) && sleep 0'
Using module file /Users/nemonik/.local/lib/python3.9/site-packages/ansible/modules/lineinfile.py
<localhost> PUT /Users/nemonik/.ansible/tmp/ansible-local-27240d5jcmaum/tmp50wpeyk8 TO /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/AnsiballZ_lineinfile.py
<localhost> EXEC /bin/sh -c 'chmod u+x /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/ /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/AnsiballZ_lineinfile.py && sleep 0'
<localhost> EXEC /bin/sh -c '/usr/bin/python3 /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/AnsiballZ_lineinfile.py && sleep 0'
<localhost> EXEC /bin/sh -c 'rm -f -r /Users/nemonik/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/ > /dev/null 2>&1 && sleep 0'
changed: [localhost] => (item={'line': 'set -U fish_user_paths $HOME/.local/bin $fish_user_paths'}) => {
    "ansible_loop_var": "item",
    "backup": "",
    "changed": true,
    "diff": [
        {
            "after": "",
            "after_header": "/Users/nemonik/.config/fish/config.fish (content)",
            "before": "",
            "before_header": "/Users/nemonik/.config/fish/config.fish (content)"
        },
        {
            "after_header": "/Users/nemonik/.config/fish/config.fish (file attributes)",
            "before_header": "/Users/nemonik/.config/fish/config.fish (file attributes)"
        }
    ],
    "invocation": {
        "module_args": {
            "attributes": null,
            "backrefs": false,
            "backup": false,
            "create": false,
            "dest": "/Users/nemonik/.config/fish/config.fish",
            "firstmatch": false,
            "group": null,
            "insertafter": "EOF",
            "insertbefore": null,
            "line": "set -U fish_user_paths $HOME/.local/bin $fish_user_paths",
            "mode": null,
            "owner": null,
            "path": "/Users/nemonik/.config/fish/config.fish",
            "regexp": null,
            "search_string": null,
            "selevel": null,
            "serole": null,
            "setype": null,
            "seuser": null,
            "state": "present",
            "unsafe_writes": false,
            "validate": null
        }
    },
    "item": {
        "line": "set -U fish_user_paths $HOME/.local/bin $fish_user_paths"
    },
    "msg": "line added"
}
META: ran handlers
META: ran handlers

PLAY RECAP ******************************************************************************************************************************************************************************
localhost                  : ok=135  changed=65   unreachable=0    failed=0    skipped=34   rescued=0    ignored=1
```

If `failed ` is something other than `0` then you have an issue to debug. Debuging will require you to review the task that resulted in the failure likely the last task run. Review the output, determine what playbook you were in, open and review the playbook and the offending task and then try the equivalent in the command line to debug the issue. The host may be in a state the playbook cannot handle. Perhaps a dependency is missing. Perhaps. Perhaps. Perhaps.

### 10.2.2. On OSX, enable nerd fonts in XTerm2

To complete the configuration for OS X hosts configure XTerm2 to use `Meslo Nerd Font` and use `Solarized Dark` color them. Optionally, you can install your own [Nerd font](https://www.nerdfonts.com/font-downloads).

1. Open iTerm2's `Preferences`.
2. In the `Preference` window that opens, select `Profile`.
3. In the `Default` profile, select `Text`.
4. In the `Text` profile, select `from the`Font` pannel.
5. Optionally, check off `Use ligatures`.
6. In the `Preferences` window, select `Color`.
7. Click `Color Preserts...` and select `Solarized Dark`.
8. Close the `Preference` windows, and re-start your terminal window for your changes to take effect.

## 10.3. Spin up the Factory

So, now that you have the prerequisite dependencies, it is time to move on to spinning up the factory.

The factory tools are entirely execute on a containerized [Kubernetes](https://github.com/kubernetes/kubernetes) cluster hosted on [k3s](https://github.com/k3s-io/k3s) (Rancher Lab’s minimal Kubernetes distribution) on Docker created by [k3d](https://github.com/rancher/k3d/). Kubernetes is used to orchestrate the life cycles the long-running tools (e.g., Taiga, GitLab, Docker CI, SonarQube, Heimdall2.) Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications. Essentially, Kubernetes serves as an operating system for a cluster of computing resource (in the cases of k3d these computing resources themselves are containers) and manages the life cycle and discovery of the applications running upon the cluster.

Initially, K3s was billed as a light-weight, CNCF certified Kubernetes distribution designed for resource-constrained environments, where one doesn't need the added steps and dependencies a full Kubernetes cluster would require. As k3s has matured it has become just a darn good Kubernetes distrobution.

It's canonical source can be found at

https://github.com/rancher/k3s/

It's landing page can be found here

https://k3s.io/

The official documentation can be found here

https://rancher.com/docs/k3s/latest/en/

### 10.3.1. The Makefile

I've chosen to author the automation for spinning up the factory in [GNU Make](https://www.gnu.org/software/make/). GNU Make bills itself as "a tool which controls the generation of executables and other non-source files of a program from the program's source files." Created by, [Stuart Feldman](https://en.wikipedia.org/wiki/Stuart_Feldman) Make introduced in PWB/UNIX has been around since 1976. Yep, over 45 years ago. Initially, its purpose was to automate software builds. Yeah, automation one of the core methods of DevOps has been around quite a long time. I've chosen to use Make since the inception of my class to drive this point home. There's alway a few "grey beards" in my class that perk up and smile after hearing it mentioned. Make lends itself well to the task of spinning up the cluster, the tools, etc as a makefile is essentially a collection of rules. An idividual rule in the makefile tells Make how to execute a series of commands. The [Makefile](Makefile) is found at the root of the repository. As I stated earlier, typically Make is utilized for building code, but because of its ubiquity across Linux and OSX it is often used for a wide variety of tasks. We're going to use it stand up a Kubernetes cluster and a top that entire DevOps factory.

First let's inspect the [Makefile](./Makefile) in piecemeal

```
# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <nemonik@nemonik.com>
```

The above is the copyright.

```
.PHONY: all install-dependencies start install start-registry delete-registry start-cluster delete-cluster patch-coredns install-traefik uninstall-traefik install-gitlab uninstall-gitlab install-drone uninstall-drone install-taiga uninstall-taiga install-sonarqube uninstall-sonarqube install-heimdall uninstall-heimdall decrypt-vault encrypt-vault
```

Generally, a makefile is comprised of rules that look like this

```
target [optionally, additional targets...] : prerequisite [optionally, additional prerequisite]
        recipe
        ...
```

Each rule begins with a line that defines usually one sometimes more than one target followed by a colon and optionally a number of files or targets on which the target depends. Followed by a tab indented recipe comprised of one or more tab indented lines. When building source code, the target is a file, but in the instance where you want your makefile to run a series of commands that do not represent physical files on the file system you are executing what make considers a "phony" target. Phony targets are the name of the recipe. GNU Make provides a built-in target named `.PHONY` where you can make your target a prerequisite of it thereby declaring your target to be phony. This is what I've done above for all of my targert. The `.PHONY` line could be skipped and the makefile will still work, but including the line makes the makefile more readable once you know what a phony target is.

What follows next are the makefile's rules

```
all: start install
start: start-registry start-cluster patch-coredns
install: install-traefik install-gitlab install-drone install-taiga install-sonarqube install-heimdall
uninstall: delete-cluster
install-dependencies:
	./install_dependencies.sh
start-registry:
	./start_registry.sh
delete-registry:
	./delete_registry.sh
start-cluster:
	./start_cluster.sh
delete-cluster:
	./delete_cluster.sh
patch-coredns:
	cd coredns && ./patch.sh
install-traefik:
	cd traefik && ./install.sh
uninstall-traefik:
	cd traefik && ./uninstall.sh
install-gitlab:
	cd gitlab && ./install.sh
uninstall-gitlab:
	cd gitlab && ./uninstall.sh
install-drone:
	cd drone && ./install.sh
uninstall-drone:
	cd drone && ./uninstall.sh
install-taiga:
	cd taiga && ./install.sh
uninstall-taiga:
	cd taiga && ./uninstall.sh
install-sonarqube:
	cd sonarqube && ./install.sh
uninstall-sonarqube:
	cd sonarqube && ./uninstall.sh
install-heimdall:
	cd heimdall2 && ./install.sh
uninstall-heimdall:
	cd heimdall2 && ./uninstall.sh
decrypt-vault:
	./decrypt-vault.sh
encrypt-vault:
	./encrypt-vault.sh
```

Earlier we entered `make install-dependencies` in our shell to install all the dependencies via Ansible. Well, we can see above the `install-dependencies` target executes a [./install_dependencies.sh](install_dependencies.sh) shell script.

In the shell, if you were to enter `make all` make would execute the `all` target, who will in turn

- execute the `start` target, who in turn will call
  - the `start-registry` target, who will execute the [./start_registry.sh](start_registry.sh) bash script
  - then the `start-cluster` target will be called execute the [./start_cluster.sh](start_cluster.sh) script
  - then the `patch-coredns` target will be called, descend into the [coredns](coredns) sub-folder and execute the [patch.sh](coredns/patch.sh) script
- then execute the `install` target, who will call
  - the `install-traefik` target, descend into the [traefik](traefik) sub-folder and execute the [install.sh](traefik/install.sh) script
  - then the `install-gitlab` target to descend into the [gitlab](gitlab) sub-folder and execute the [install.sh](gitlab/install.sh) script
  - then the `install-drone` target to descend into the [drone](drone) sub-folder and execute the [install.sh](drone/install.sh) script
  - then the `install-taiga` target to descend into the [taiga](taiga) sub-folder and execute the [install.sh](taiga/install.sh) script
  - then the `install-sonarqube` target to descend into the [sonarqube](sonarqube) sub-folder and execute the [install.sh](sonarqube/install.sh) script
  - and finally, the `install-heimdall` target to descend into the [heimdall](heimdall) sub-folder and execute the [install.sh](heimdall/install.sh) script
