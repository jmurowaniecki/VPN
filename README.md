# Configurador de VPN genérico

Este script auxilia a configuração e execução dos passos básicos utilizando VPN.

![][shield-Ubuntu] 
![][shield-Fedora] 
![][shield-Garuda] 
![][shield-Arch  ] 

# Utilizando OpenVPN via theSail

Você deve receber do administrador seu nome de usuário e senha temporários para acessar o nodo de VPN.

Por exemplo:

> User: **carlos.santanna**
> 
> Pass: **QmxhY2sgbWFnaWMgd29tYW4K** _(altere a senha assim que possível)_
> 
> URL: https://huebr-node-vpn.thesail.pro/

Com a VPN instalada utilizando os links acima de acordo com o seu dispositivo, acesse o portal da VPN através de seu navegador.

Ao acessar o portal pela primeira vez, será necessário cadastrar um dispositivo de autenticação de dois passos (2fa). Utilize o seu software atual de 2fa, como por exemplo o Google Authenticator, Yubiko otp, etc.

Após cadastrar e acessar com sucesso, clique no link Yourself (user-loked profile) para baixar as credenciais de acesso:

![](assets/tela-download.png)

Salve o arquivo em sua pasta `~/.profile.ovpn`

# Configurações

Executar o script `connect.sh` testará pela existência do client do OpenVPN instalado em sua máquina, pelos arquivos `~/.profile.ovpn` e `~/.profile.secret`.
- Caso o cliente não seja encontrado você deve instalar e configurar ele como previsto para o seu sistema ou distribuição.
- O arquivo `.ovpn` deve ser obtido pelo painel da sua provedora VPN;
- O arquivo `.secret` pode ser preenchido manualmente com seu usuário e senha no formato `auth-user-pass`;
- O arquivo `.secret` pode ser preenchido automaticamente na primeira execuç~ao do `connect.sh`;




[shield-Ubuntu]: https://img.shields.io/badge/Ubuntu-20.04-dd4814?style=for-the-badge&logo=Ubuntu
[shield-Fedora]: https://img.shields.io/badge/Fedora-35-0B57A4?style=for-the-badge&logo=Fedora
[shield-Arch  ]: https://img.shields.io/badge/Arch-Rolling-1793d1?style=for-the-badge&logo=ArchLinux
[shield-Garuda]: https://img.shields.io/badge/Garuda-Rolling-002561?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFsAAABFCAYAAAAl6ppyAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAADbQAAA20BvfK7DgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAATUSURBVHic7dxtjFxTHMfxz64tWmx1W6H0QdGkDSkJ6oXEtqQipUWkIikrkfCShHhKvEAIwpvGGxLSN5p4aESCBBGJBvFUQSJBgrZJUey29AFd7XpxttnpdHb2zsw998yd9pv8cncme+ee85sz555z/v9zu5SDE/A8VmB7E/odw4WXuoqu1AXIwCKsx/wWP+dPwfghB38RQ1XHzfisxWuVkhuxCyMFap/wCzpsOAZrFGtypf7COdFr2QbMwcfSGX1AP2JG5Lom5UoMSm/0Ab2Dnqg1TsBReFDoL1MbXK2n4lW7eGbgbelNradbotW+QC7EJunNnEh/Y3EcC4rhNvwrvZFZ9TNOi+JERHrxivTmNaOPMDl/S+KwAN9Ib1or2ibczPvytSZfVit+NhhTO4WJ15w8TWqV1LPB2NqLl4WbfVLmCos6qQ0pQvtxbT0zYq76nYpHcBymYym6I16vHdiB84WpfuFMwh06q6+eSF/i2DzMa4RLlH/k0ayezsG/TPThWaEPS13plFrdqpH16MKAEIJKXdF20E5hXpE75wqzq9QVbDd9LccZ5xRhNrW3DSrWrnqmWXMrWSEER1NXpgy6qUmPzRKi3akrUCbtxMJGTJ6E+7G7DQpfRm3MavSBMfMeR7qOZvXDRNPnLlwqhPUHhDH0tgnOOUJtNjW6NnIPnohRkgL5SghenFilaRV/T5V/VH1tIx+4AA/lXIAU7MCjGf7veId+IdWaqvaX1efQRb7NWQvYjQ+l7/fy0E9ZK90Cv9a47s1ZT76zxsll1V4hTyUmtQLZS7KcOE8YJ6Y2KU/FjJL3jnPN0ycajXRjrdB/dRJzI352rUDwPmydyOy70Z9/eZITM0g7rcZ7n2C4ntkDeCxOeZIT0+zqzNeNWMn4McFrhG0VZdiZ0Awxza7sRj4QJoWD1Db7MryoA1NlK4hp9vTR4wYsFxLrcajZF+E1Idejk4ndst/CFcIoriaLhE08qYdlRWh7Y/41xDITNNaz8MtoQf7LUNhOUG92//KhWxjgv47PcT3WFV2IRCTJ0es3NjachD+kb3VFaHnLzjVID96veL3M2N200ym8ZVePRlZVvR4UWnonktTso3H16N+7hCBBv7Bm24kkzateiX+E1LGTR997Uvq+NZY25OBZ01yOmRWve4WoRmpTYilz5KQI7pLekJga1iZLEj0Oj5SF2XkZloXxVv1WGbuB7BMCvZmTTErESakLQFjsHsEWIUGHzopDjggpdMlZKhTmVQevzc7UOesmW7TJPsb1wj6YWrwnvVGtahgXN29PfkxWP1v+VunNalUPNOlN4fQp1+b+au2WMFOg0X2JQ0IUoqwMKtFGf7hB+hbajPZogy3PjTJF+TKk9guNpJSsk97ARvRwHBuK4SrpDcyqd5V8z3x1+GwNPpXO0Hr6XsnNJuzvG8GbQuZUl7Cm8p30BldrWSQPCqMfv+GUqvd7hIdtbZXe5N24Vwe07G5ji1S1mIL7hISYFEa/oeAl1HZgGh4XxrkjeAlnC9uwv5W/yUPCL+uwZhaeEzJkKzlPGJrl8WyS/Ur47L1ULBQWir4wvqFb1X9m65KiC52Vds6/PgPXjWqxsbIuEB4pOk/IUZw/ejxz9PiC0EUdoUlm43Yhe+uCxGVpmv8B2Y/+BADS4Q4AAAAASUVORK5CYII=&logoColor=2F6F7E