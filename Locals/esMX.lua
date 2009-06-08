local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "esMX" )

if not L then return end

--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

L["Location"] = true
L["Left-click to |cFF00FF00open"] = "Botón izquierdo para |cFF00FF00abrir"
L["Right-click to |cFF00FF00drag"] = "Botón derecho para |cFF00FF00desplazar"
L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = "Introduce un nombre que sólo se usará para |cFF00FF00mostrar|r."
L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = "Este nombre puede ser cualquiera,\n|cFF00FF00NO|r hace falta que sea un nombre real."
L["This field |cFF00FF00cannot|r be left empty."] = "Este campo |cFF00FF00no puede|r ser dejado en blanco."

L["Summary"] = "Resumen"
L["Characters"] = "Personajes"

L["Account Summary"] = "Resumen de la Cuenta"
L["Bag Usage"] = "Bolsas"
L["Activity"] = "Actividad"
L["Guild Members"] = "Miembros hermandad"
L["Guild Skills"] = "Habilidades hermandad"
L["Guild Bank Tabs"] = "Banco de hermandad"
L["Calendar"] = true

L["Account Sharing Request"] = "Petición de compartir cuenta"
L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"] = "Click en este botón para pedir a un jugador\nque comparta su base de datos de Altoholic entera\ny añadirla a la tuya"
L["Both parties must enable account sharing\nbefore using this feature (see options)"] = "Ambas partes han de activar la compartición de cuenta\nantes de usar esta característica (ver opciones)"
L["Account Sharing"] = "Compartición de cuenta"

L["Realm"] = "Reino"
L["Character"] = "Personaje"
L["View"] = "Ver"

L["Item / Location"] = "Objeto / Ubicación"

L["Hide this guild in the tooltip"] = "Oculta esta hermandad de la lista"

L["Not started"] = "No iniciado"
L["Started"] = "Iniciado"

L["General"] = true
L["Tooltip"] = true

L["Totals"] = "Totales"
L["Search Containers"] = "Buscar contenedores"
L["Equipment Slot"] = "Tipo de equipo"
L["Reset"] = "Reiniciar"

L["Account Name"] = "Nombre de cuenta"
L["Send account sharing request to:"] = "Mandar petición de compartir cuenta a:"

--TabOptions.lua

-- ** Frame 1 : General **
L["Max rest XP displayed as 150%"] = "Mostrar el maximo de XP reposado como 150%"
L["Show FuBar icon"] = "Mostrar icono FuBar"
L["Show FuBar text"] = "Mostrar texto FuBar"
L["Account Sharing Enabled"] = "Compartición de cuenta activado"
L["Guild Communication Enabled"] = "Comunicación con hermandad activada"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a otros usuarios\nde Altoholic enviarte peticiones para compartir cuenta.\n"
L["Your confirmation will still be required any time someone requests your information.\n\n"] = "Se te pedirá confirmación cada vez que alguien solicite tu información.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = "Si está |cFFFF0000desactivada|cFFFFFFFF, todas las peticiones serán automáticamente rechazadas.\n\n"
L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = "Consejo de seguridad: Actívalo sólo cuando necesites transferir datos,\ndesactívalo el resto del tiempo"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\nto see your alts and their professions.\n\n"] = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a tus compañeros de hermandad\nver tus alters y sus profesiones.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."] = "Si está |cFFFF0000desactivada|cFFFFFFFF, no habrá comunicación con la hermandad."

L["Automatically authorize guild bank updates"] = "Autorizar automáticamente las actualizaciones el banco de la hermandad"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a otros usuarios de Altoholic\nactualizar su información del banco de la hermandad con la tuya..\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = "Si está |cFFFF0000desactivada|cFFFFFFFF, se te pedirá confirmación\nantes de mandar ninguna información.\n\n"
L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = "Consejo de seguridad: desaciva esto si tienes permisos de oficial\nen pestañas del banco de la hermandad que no deben ser vistas por todos,\ny autoriza las peticiones manualmente"
L["Transparency"] = true

-- ** Frame 2 : Search **				
L["AutoQuery server |cFFFF0000(disconnection risk)"] = "Comprobación automática |cFFFF0000(riesgo de desconexión)"
L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"] = "|cFFFFFFFFSi un objeto no esta en la caché local de objetos\ny es encontrado mientras se realiza una búsqueda,\nAltoholic preguntará al servidor por 5 nuevos objetos.\n\n"
L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"] = "Esto mejorará gradualmente la consistencia de las busquedas,\nya que habrá mas objetos en la cache de objetos.\n\n"
L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"] = "Aun así, hay un riesgo de desconexión al preguntar por un objeto\nsi es un drop de una instancia de alto nivel.\n\n"
L["|cFF00FF00Disable|r to avoid this risk"] = "|cFF00FF00deshabilitar|r para evitar este riesgo"

L["Sort loots in descending order"] = "Ordenar saqueos en orden decreciente"
L["Include items without level requirement"] = "Incluir objetos sin requerimientos de nivel"
L["Include mailboxes"] = "Incluir buzones de correo"
L["Include guild bank(s)"] = "Incluir bancos de hermandad"
L["Include known recipes"] = "Incluir recetas conocidas"

-- ** Frame 3 : Mail **
L["Warn when mail expires in less days than this value"] = "Advertir cuando el correo expira en menos días que los indicados"
L["Mail Expiry Warning"] = "Advertencia de expiración del correo"
L["Scan mail body (marks it as read)"] = "Analizar el contenido de los correos (marcarlos como leídos)"
L["New mail notification"] = "Notificación de nuevo correo"
L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"] = "Serás avisado cuando un compañero de hermandad mande un correo a uno de tus alters.\n\nEl contenido del correo se verá directamente sin tener que reconectar con ese personaje"

-- ** Frame 4 : Minimap **
L["Move to change the angle of the minimap icon"] = "Mover para cambiar el ángulo del icono en el minimapa"
L["Minimap Icon Angle"] = "Angulo del icono del minimapa"
L["Move to change the radius of the minimap icon"] = "Mover para cambiar el angulo del icono en el minimapa"
L["Minimap Icon Radius"] = "Radio del icono del minimapa"
L["Show Minimap Icon"] = "Mostrar icono del minimapa"

-- ** Frame 5 : Tooltip **
L["Show item source"] = "Mostrar origen del objeto"
L["Show item count per character"] = "Mostrar recuento de objetos por personaje"
L["Show total item count"] = "Mostrar recuento total de objetos"
L["Show guild bank count"] = "Mostrar recuento de objetos en el banco de la hermandad"
L["Show already known/learnable by"] = "Mostrar conocido/puede aprenderse por"
L["Show item ID and item level"] = "Mostrar ID y nivel del objeto"
L["Show counters on gathering nodes"] = "Mostrar contadores en los nodos de recolección"
L["Show counters for both factions"] = "Mostrar contadores de ambas facciones"
L["Show counters for all accounts"] = "Mostrar contadores de todas las cuentas"
L["Include guild bank count in the total count"] = "Include guild bank count in the total count"

-- ** Frame 6 : Calendar **
L["Week starts on Monday"] = true
L["Warn %d minutes before an event starts"] = true
