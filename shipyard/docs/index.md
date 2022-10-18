---
id: gettingstarted
title: Getting Started
---

<TerminalVisor>
  <Terminal target="tools.container.shipyard.run" shell="/bin/bash" workdir="/" user="root" id="tools" name="Tools"/>
  <Terminal target="tools.container.shipyard.run" shell="/bin/bash" workdir="/config" user="root" id="test" name="Test"/>
</TerminalVisor>

## Accessing the Consul UI

To open the Consul UI click this link to open the UI in your browser.

<p><a href="https://1-consul-server.container.shipyard.run:8501/ui/vms/services" target="_blank">https://1-consul-server.container.shipyard.run:8501/ui/vms/services</a></p>

<TerminalRunCommand target="tools">
  <Command>clear</Command>
  <Command>kubectl get pods --all-namespaces</Command>
</TerminalRunCommand>

```shell
clear;
kubectl get pods --all-namespaces
```

<TerminalRunCommand target="test">
  <Command>clear</Command>
  <Command>kubectl get pods --all-namespaces</Command>
</TerminalRunCommand>
