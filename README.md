## Pushing HTTPS

pshtt (_"pushed"_) is a tool to test domains for HTTPS best practices.

### Getting Started

After downloading, you must first install all dependencies via pip:

```bash
pip install -r requirements.txt
```

#### Usage
```bash
./pshtt_cli [options] <domain>
./pshtt_cli [options] INPUT
```
If the first INPUT ends with `.csv`, domains will be read from CSV. CSV output will always be written to disk, defaulting to results.csv.

##### Options:

```bash
  -h --help                   Show this message.
  -s --sorted                 Sort output by domain, A-Z.
  -o --output=OUTFILE         Name output file. (Defaults to "results".)
  -j --json                   Get results in JSON. (Defaults to CSV.)
  -d --debug                  Print debug output.
  -u --user-agent=AGENT       Override user agent
  -t --timeout=TIMEOUT        Override timeout (in seconds)
  -p --preload-cache=PRELOAD  Cache preload list, and where to cache it.
```

##### Examples

```bash
./pshtt_cli dhs.gov
./pshtt dhs.gov us-cert.gov
./pshtt_cli --sorted current-federal.csv
```

## What's Checked?

A domain is checked on its four endpoints:

* `http://`
* `http://www`
* `https://`
* `https://www`

The following values are returned in `results.csv`:

* `Live` - If any of the endpoint respond it is True
* `Redirect` - If any of the endpoints redirect it is True
* `Valid HTTPS` - True if a either HTTPS endpoint is live or HTTP endpoints forward to HTTPS
* `Defaults HTTPS` - If the HTTP endpoint forwards to a HTTPS
* `Downgrades HTTPS` - If a HTTPS endpoint forwards to HTTP
* `Strictly Forces HTTPS` - If only HTTPS endpoints are live or if a HTTP endpoint is live it forwards to HTTPS
* `HTTPS Bad Chain` - If the cert is not trusted based on CA stores
* `HTTPS Bad Host Name` - If the cert fails hostname validation
* `Expired Cert` - If the cert has expired
* `Weak Signature Chain` - A SHA-1 cert exists in the cert chain
* `HSTS` - If a Strict Transport Security header is found in the HTTPS endpoint (not the https://www subdomain)
* `HSTS Header` - The contents of the HSTS Header
* `HSTS Max Age` - The Max Age of the HSTS Header
* `HSTS All Subdomain` -If "include sub subdomains" is in the HSTS header
* `HSTS Preload` - If "preload" is in the HSTS Header
* `HSTS Preload Ready` - If the domains has HSTS, HSTS Max Age, HSTS All Subdomains, and HSTS Preload
* `HSTS Preloaded` - If the domain is on the Google Chrome Preload list
* `Broken Root` - If the http:// and https:// domains are not live
* `Broken WWW` - if the http://www. and https://www. are not live

## What's this for?

This was developed to help federal .gov domains comply with [M-15-13](https://https.cio.gov), an Office of Management and Budget memorandum that requires federal agencies to enforce HTTPS on their web sites and services.

`pshtt` also includes data regarding a domain's state in the [HSTS preload list](https://hstspreload.appspot.com).

## Acknowledgements

This code was modeled after [Ben Balter](https://github.com/benbalter)'s [site-inspector](https://github.com/benbalter/site-inspector), with significant guidance from [@konklone](https://github.com/konklone).

## Public domain

This project is in the worldwide [public domain](LICENSE.md).

This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
