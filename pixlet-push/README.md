# Pixlet Push - Home Assistant Add-on

![Support][support-shield]
![Sponsor][sponsor-shield]

This add-on allows you to run web server for pushing [Pixlet](https://github.com/tidbyt/pixlet) graphics to [Tidbyt](https://tidbyt.com/) LED displays on your Home Assistant instance.

For more details about Pixlet, please see [Pixlet's documentation](https://github.com/tidbyt/pixlet).

## Installation

Add this repository to your add-ons by navigating to Supervisor -> Add-on Store -> Repositories and adding the following URL:

```txt
https://github.com/nwithan8/hassio-addons
```

or by clicking the button below:

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fnwithan8%2Fhassio-addons)


## Usage

Store your Pixlet graphics (`.star` files) in the `pixlet_push` directory under `addon_configs` on your Home Assistant instance's filesystem.

Push a graphic to your Tidbyt display by sending a POST request to the add-on's web server:

```bash
curl -X POST -F "device_id=<TIDBYT_DEVICE_ID>" -F "api_key=<TIDBYT_API_KEY>" -F "file=@/path/to/your/file.star" http://<your-hassio-ip>:5300/push
```

### Home Assistant Shell

You can also push graphics using the `shell_command` integration in Home Assistant, by adding the following to your `configuration.yaml`:

```yaml
shell_command:
    tidbyt_display: 'curl -X POST -F "device_id=<TIDBYT_DEVICE_ID>" -F "api_key=<TIDBYT_API_KEY>" -F "file=@/config/pixlet_files/{{ file }}.star" http://localhost:5300/push
```

Call the service from Home Assistant with the following:

```yaml
service: shell_command.tidbyt_display
data:
    file: coffee
```

[support-shield]: https://img.shields.io/badge/Support_Me-Buy_Me_A_Coffee?style=for-the-badge&logo=buymeacoffee&color=blue&link=https%3A%2F%2Fwww.buymeacoffee.com%2Fnwithan8
[sponsor-shield]: https://img.shields.io/badge/Sponsor_Me-GitHub_Sponsors?style=for-the-badge&logo=githubsponsors&color=green&link=https%3A%2F%2Fgithub.com%2Fnwithan8%2F
