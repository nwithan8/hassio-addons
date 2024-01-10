# Willow Autocorrect - Home Assistant Add-on

![Support][support-shield]
![Sponsor][sponsor-shield]

This add-on allows you to run a [Willow Autocorrect](https://github.com/toverainc/willow-autocorrect) instance on your Home Assistant server.

For more details about Willow, please visit [Willow's website](https://heywillow.io/).


## Installation

Add this repository to your add-ons by navigating to Supervisor -> Add-on Store -> Repositories and adding the following URL:

```txt
https://github.com/nwithan8/hassio-addons
```

or by clicking the button below:

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fnwithan8%2Fhassio-addons)


## Configuration

### Access Token

You will need to provide a long-lived access token for your Home Assistant instance.

You can create a token by navigating to your Home Assistant instance and going to your profile page. Scroll down to the bottom and click "Create Token". 

Copy the token and paste it into the Configuration tab for this add-on.

### WAS Settings

After filling out the Configuration details, you can start the add-on, which will run a WAC server at `http://<your-hassio-ip>:9241`.

In your WAS (Willow Application Server) settings, you will need to change the "Command Endpoint" to point to your WAC instance.

![WAS settings][screenshot]

Use the following settings:

- **Command Endpoint**: REST
- **REST URL**: `http://<your-hassio-ip>:9241/api/proxy`
- **REST Authentication Method**: None

Save and apply the settings to all your satellites.

You can confirm the functionality is working by asking your satellite an invalid command, to which it should respond "Sorry, I can't find that command."

[support-shield]: https://img.shields.io/badge/Support_Me-Buy_Me_A_Coffee?style=for-the-badge&logo=buymeacoffee&color=blue&link=https%3A%2F%2Fwww.buymeacoffee.com%2Fnwithan8
[sponsor-shield]: https://img.shields.io/badge/Sponsor_Me-GitHub_Sponsors?style=for-the-badge&logo=githubsponsors&color=green&link=https%3A%2F%2Fgithub.com%2Fnwithan8%2F
[screenshot]: https://raw.githubusercontent.com/nwithan8/hassio-addons/master/images/willow-autocorrect/was_settings.png
