---
title: "ModSecurity"
date: 2019-10-01
categories: [Sec]
tags: [WAF, ModSecurity]
---

* ModSecurity - a WAF engine (library, module) for Apache, Nginx, IIS
* Core Rule Set (CRS) - define the malicious patterns (signatures)

## ModSecurity

* `/etc/nginx/modsec/modsecurity.conf` - config file
* audit logs are great for visibility but bad for performance - you can disable them via `SecAuditEngine off` (you still have the Nginx error logs)
* you should not inspect static content (images, ...) for performance reasons
* https://www.modsecurity.org

## CRS

* blacklist rule set
* should be used for all ModSecurity deployments
* `crs-setup.conf` - config file
* `rules` - directory with rules (you should modify only `*EXCLUSION-RULES*`)
* to tune, set a high anomaly threshold and progressively lower it
* https://coreruleset.org, https://github.com/SpiderLabs/owasp-modsecurity-crs, https://www.modsecurity.org/CRS/Documentation/

Paranoia levels:

1. (default) basic security, minimal amount of false positives (FPs)
2. elevated security level, more rules, fair amount of FPs
3. online banking level security, specialized rules, more FPs
4. nuclear powerplant level security, insane rules, lots of FPs

## Attacks for testing WAF

```
curl http://$FQDN/?exec=/bin/bash # Remove Code Execution (RCE)
```
