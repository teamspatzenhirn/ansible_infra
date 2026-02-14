import discord
import requests
import os

url = os.environ.get('ESP_URL')
discord_key = os.environ.get('DISCORD_KEY')
request_timeout=2#[s]

class MyClient(discord.Client):
    async def on_ready(self):
        print(f'Logged on as {self.user}!')

    async def on_message(self, message):
        print(f'Message from {message.author}: {message.content}')
        print(f'Channel: {message.channel}')

        if ("auf" in message.content.lower()) and (str(message.channel) == "tür"):
            try:
                x = requests.post(url, timeout=request_timeout)
                if x.status_code == 200:
                    pass
                else:
                    print(f'ERROR: status_code={x.status_code}')
            except requests.exceptions.Timeout:
                await message.reply('Ich konnte den ESP nach {} Sekunden nicht erreichen :('.format(request_timeout), mention_author=True)

intents = discord.Intents.default()
intents.message_content = True

client = MyClient(intents=intents)
client.run(discord_key)