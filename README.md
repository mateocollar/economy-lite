# economy-lite
Plugin de economía para CurseStone (Minecraft: Pocket Edition v0.15.10)

#### Instala [CurseStone](https://github.com/CurseStoneTeam/CurseStone/releases) <--

# Instalación

1. Instala el .zip en la página de [releases](https://github.com/mateocollar/economy-lite/releases) (El primer resultado).
2. Descomprime ese zip en una carpeta llamada `economy-lite` dentro de `~/plugins/`.
3. Inicia el servidor.

## Comandos

| Comando | Descripción | Uso | Permiso |
|---|---|---|---|
| `/bal` | Muestra tu balance o el de otro jugador | `/bal [jugador]` | No |
| `/eco` | Comandos administrativos de economía | `/eco <take\|give\|set> <jugador> <cantidad>` | OP |
| `/pay` | Paga dinero a un jugador | `/pay <jugador> <cantidad>` | No |
| `/topcoins` | Muestra los X jugadores con más dinero | `/topcoins` | No |

# Configuración

Archivo: `~/data_pl/economy-lite/config.yml`

| Clave | Valor por defecto | Descripción |
|---|---|---|
| `currency` | `"$"` | Símbolo de la moneda mostrado en los mensajes |
| `initial_balance` | `100` | Balance inicial al crear el perfil de un jugador |
| `max_balance` | `1000000` | Balance máximo que puede alcanzar un jugador |

Ejemplo:

```yaml
currency: "$"
initial_balance: 100
max_balance: 1000000
```

## Autor

- [mateocollar](https://github.com/mateocollar)
