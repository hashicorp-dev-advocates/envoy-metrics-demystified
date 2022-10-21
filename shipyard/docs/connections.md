---
id: connections
title: Connections
---

Let's examine connection metrics, in Envoy connection metrics are related to the Listener, if you remember back from the 
introduction a Listener in Envoy is an open port bound to a specific address that accepts connections, generally forwarding
to an upstream cluster.

### Common Connection Metrics
In this section we will learn how to query envoys metrics to understand the current number of active connections, the number
of connections opened per second, and the number of connections closed per second. We are going to use the following metrics. 

| Name                  | Type    | Description                 |
| --------------------- | ------- | -----------------           |
| downstream_cx_active  | Gauge   | Total active connections    |
| downstream_cx_total   | Counter | Total connections           |
| downstream_cx_destroy | Counter | Total destroyed connections |

The chart you are going to create will look something like the following, and will show the downstream connections to the `API` service
along with the upstream connections from the `API` service to the `Payments` service.

#### Figure 1.0 API Connections
![](./images/api_connections_1.png)

### Downstream Connections

To query statistics using Grafana and Prometheus you can use the Explore feature, if you are using Instruqt you can switch to
this tab in your browser.

In the `Metrics browser` box enter the text `envoy_http_downstream_cx_active`, as you type Grafana will autocomplete the 
metrics names that Prometheus has available to it.

You can also change the time period that you would like to use when querying the data, choose 5 minutes from the box in the 
top right corner.

You should see data that looks something like the following:

#### Figure 1.1 API Active Downstream Connections

![](./images/api_connections_2.jpg)

You will see that there are a number of different metrics displayed, these are from many different services and listeners.
To see the data for the image that we would like to use we can filter the returned metrics using the tags that are attached to 
the metrics.

If you press `space` inside the brackets for the metric `envoy_http_downstream_cx_active{}` grafana will start to autocomplete
the tags that are available. Let's add the tag `service` and set the value to `api`, and also lets filter further by
setting the `envoy_listener_address` to the value `envoy_listener_address=~".*_20000"`.

Note that in the last value you are using a regular expression `.*_20000` to use a tag value that matches everything up to 
the value `_20000`

The listener address is set by Envoy and contains the ip and port, of the listener, for example `10.42.0.26_20000`, depending
on your particular service mesh different tags will probably be used. With Consul the public listener for a service
is by default listening on port `20000` so we can use this to filter our metrics.

You should have query that looks something like the following.  

```javascript
envoy_listener_downstream_cx_active{service="api", envoy_listener_address=~".*_20000"}
```

You should also see that there are approximately `20` active connections, the metric `envoy_listener_downstream_cx_active` is a Gauge
that means it is a snapshotted value at the point in time when the data was scraped.

What this indicates is that there is a stable connection pool of `20` connections to the API service from the Ingress.

Let's now add this to the dashboard.

### Envoy Listener Statistics:
A full list of Envoy listener statistics can be found at the link below:

<a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/listeners/stats#listener-manager" target="_blank">
https://www.envoyproxy.io/docs/envoy/latest/configuration/listeners/stats#listener-manager
</a>
