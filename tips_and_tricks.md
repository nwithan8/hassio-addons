### Accessing options

If the container is built on the HA container base and has [bashio](https://github.com/hassio-addons/bashio):

```bash
#!/usr/bin/env bashio

USERNAME=$(bashio::config 'username')

bashio::log.info "${USERNAME}"
```

Otherwise, options are available in `/WORKING_DIRECTORY/options.json`:

```bash
#!/usr/bin/env bash
set -e

CONFIG_PATH=/WORKING_DIRECTORY/options.json

USERNAME=$(jq --raw-output '.username // empty' $CONFIG_PATH)

echo "${USERNAME}"
```
[More details](https://github.com/hassio-addons/bashio?tab=readme-ov-file#configuration), courtesy of Frenck.
