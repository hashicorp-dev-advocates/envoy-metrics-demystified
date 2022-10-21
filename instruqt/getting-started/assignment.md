---
slug: getting-started
type: challenge
title: "Getting Started"
teaser: "Set up the workshop environment."
notes:
  - type: text
    contents: Replace this text with your own text
tabs:
  - title: Interactive Terminal
    type: terminal
    hostname: shell

  - title: Docs
    type: service
    hostname: shipyard
    path: /
    port: 3000

  - title: Grafana Explore
    type: service
    hostname: shipyard
    path: /explore
    port: 8080

  - title: Grafana Dashboards
    type: service
    hostname: shipyard
    path: /dashboards
    port: 8080

difficulty: basic
timelimit: 7200
---

In this step, you'll familiarize yourself with the [Shipyard CLI](https://shipyard.run) and verify your workshop environment is ready for this session.

---

# 1.) Verify the Shipyard CLI is correctly set up

Shipyard requires Docker, Git, and a template (also known as a blueprint) to run.

* Verify Shipyard is correctly set up by running `shipyard check` from any directory.

* Verify your output looks like this:

```
###### SYSTEM DIAGNOSTICS ######
 [  OK  ] Docker
 [  OK  ] Git
 [  OK  ] xdg-open
```

> ⚠️ Depending on the state of this workshop machine, you might see `Podman` mentioned in the output. For this workshop, Podman is not used, so any warning or error related to it may be safely ignored.

---

# 2.) Pull the latest changes of the workshop files

* Change into the workshop files directory by running `cd envoy-metrics-demystified`.

* Pull the latest changes for the workshop files by running `git pull`.

  > ⚠️ If you see a message saying `Already up to date.`, your machine already has the latest version of the workshop files. You may safely continue on!

---

# 3.) Verify that all workshop files have been deployed successfully

* Verify that the workshop files have been deployed by running `shipyard status` from anywhere.

  > ⚠️ If `shipyard status` lists any error (identified by status `failed`), continue with step 4 to (re)provision your workshop environment.

* If you do not encounter any errors, click the green "Next" button in the lower right corner to proceed to the next challenge.

---

# 4.) Optional: Deploy the workshop files using the Shipyard CLI

> ⚠️ This step is only required if you encountered any errors in the previous step.

* Change into the workshop files directory by running `cd envoy-metrics-demystified`, followed by `cd shipyard`, if you haven't yet.

* Deploy the workshop files using the Shipyard CLI by running `shipyard run /root/envoy-metrics-demystified/shipyard`.

  > ⚠️ The `shipyard run` step will provision the services we need for this workshop. This includes K3s, Envoy, Grafana, Prometheus, Consul, and an application (`fakeservice`) to help with generating metrics.
  > This step _may_ take a while, as a lot of different parts are downloaded and configured.
