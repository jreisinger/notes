---
title: "Devops"
date: 2016-11-20
draft: false
tags: [devops]
categories: [note]
---

> The opposite of DevOps is despair. -- Gene Kim

> If HW and SW are sufficiently fault tolerant, the remaining problems are human. -- TPoCSA

> CAMS: culture, automation, measurement, and sharing. -- D. Edwards, J. Willis (2010)

DevOps is a set of techniques to solve the chronic conflict between Development
an IT Operations. This conflict causes:

* increased time to market
* problematic code deployments
* increased number of Sev 1 outages
* unplanned work
* technical debt

The techniques are:

* architecture and processes
* technical practices
* cultural norms

DevOps is an emerging field in operations. The practice of DevOps typically appears in web application and cloud environments, but its influence is spreading to all parts of all industries.

The principles behind DevOps work patterns are the same principles that
transformed manufacturing.

DevOps has been formed by:

* Lean principles
* Agile Community
* Infrastructure as Code
* CI, CD
* Innovation Culture
* Toyota Kata

"The Three ways" are the underpinning principles that all the DevOps patterns
can be derived from.

The First Way - workflow
------------------------

To maximaze left-to-right flow of work (from Dev to Ops to the customer) we need:

* each step is done in a repeatable way
* small batch sizes and intervals of works
* never passing defects to downstream work centers
* local optimization must not degrade global performance (optimmize for global goals)

Necessary practices:

* continuous build, CI, CD
* environments on demand
* limiting WIP
* building safe to change systems and organizations

The Second Way - feedback
-------------------------

To prevent problems from happening again or enable faster detection and recovery we need:

* constant flow of fast feedback from right-to-left at all stages of the value stream

Practices:

* stopping the production line when builds/tests go wrong
* constantly elevating the improvements of daily work over daily work
* fast automated test suites
* shared goals and shared pain between Devs and Ops
* pervasive telemetry

The Third Way - experimentation & repetition (kata)
---------------------------------------------------

Create culture that fosters:

* *continual* experimentation (risk taking and learning from success and failure)
* understanding that repetition and practice is the prerequisite to mastery

Practices:

* rewarding innovation and risk taking
* rewarding improvements
* at least 20% of Dev and Ops cycles allocated towards nonfunctional requirements

DevOps without Devs
-------------------

It's possible to apply these DevOps principles to any complex process:

1) Turn chaotic processes into repeatable, measurable ones.
* document process until consistent => automate => self-service

2) Automate.

* to scale don't do IT tasks but maintain the system that does the IT tasks

3) Talk about problems and issues within and between teams.

* don't obscure or suffer through problems
* have channels for communicating problems and issues

4) Try new things, measure the results, keep the successes, and learn from the failures.

* create a culture of learning and experimentation
* use management practices that are blameless and reward learning

5) Do work in small batches so we can learn and pivot along the way.

* it's better to deliver some results each day than to hold back and deliver the entire result at the end
* you'll get feedback and fix problems sooner and avoid too much waisted effort

6) Drive configuration and infrastructure from machine readable sources kept under a source control system.

* IaC is flexible, testable and can benefit from software engineering techniques

7) Always be improving.

* always be identifying the next big bottleneck and experiment to fix it
* don't wait for a major disaster

8) Pull, don't push.

* build processes to meet demand, not accommodate supply
* determine the desired weekly output, allocate resources, and pull the work through the system to completion

9) Build community.

* you, your team, your company and world's IT community are interdependent

Injecting modern concepts into legacy processes
-----------------------------------------------

1) Identify the team’s value streams — processes done for the business, or requested by the business.

2) Each step in the process needs to be clearly defined so that it can be done in a repeatable fashion. That is, a reasonably well-trained person should be able to do the step and the result will be the same as the result from another reasonably trained person.

3) Once the process is defined, amplify the feedback loops. That is, make sure each step has a way to raise the visibility of problems so that they are worked on, not ignored. Collect measurements on the length, frequency, and failure rate of the steps. Make this data available to all involved.

4) Based on the feedback find pain points (steps that are the most error prone, unreliable, or slow) and build business case

* What problem really needs to be solved?
* Gather metrics showing how things can improve.
* Make business case showing why we need change and what we will get.

5) Find allies, share and collaborate

* Ex. find people outside your team who can benefit from the change.

6) Start small and build from the bottom up

* Start with something easy to build confidence while working out issues.
* Ex.: document => share documentation => automate (script) => automate more
  (Jenkins, RunDeck)

Source
------

* [The Phoenix Project](https://itrevolution.com/book/the-phoenix-project/)
* [TPoSaNA](http://the-sysadmin-book.com/)
* [TPoCSA](http://the-cloud-book.com/)
* http://sysadvent.blogspot.sk/2016/12/day-13-injecting-modern-concepts-into.html

More
----

* https://www.oreilly.com/ideas/what-is-devops-yet-again
