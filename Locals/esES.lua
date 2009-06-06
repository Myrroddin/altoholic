local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "esES" )

if not L then return end

--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

if GetLocale() == "esES" then
-- Altoholic.xml local
LEFT_HINT = "Botón izquierdo para |cFF00FF00abrir";
RIGHT_HINT = "Botón derecho para |cFF00FF00desplazar";

XML_ALTO_SHARING_HINT1 = "Introduce un nombre que sólo se usará para |cFF00FF00mostrar|r.\n"
                .. "Este nombre puede ser cualquiera,\n|cFF00FF00NO|r hace falta que sea un nombre real.\n\n"

XML_ALTO_SHARING_HINT2 = "Este campo |cFF00FF00no puede|r ser dejado en blanco."

XML_ALTO_TAB1 = "Resumen"
XML_ALTO_TAB2 = "Personajes"
XML_ALTO_TAB3 = "Buscar"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Opciones"

XML_ALTO_SUMMARY_MENU1 = "Resumen de la Cuenta"
XML_ALTO_SUMMARY_MENU2 = "Bolsas"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Actividad"
XML_ALTO_SUMMARY_MENU5 = "Miembros hermandad"
XML_ALTO_SUMMARY_MENU6 = "Habilidades hermandad"
XML_ALTO_SUMMARY_MENU7 = "Banco de hermandad"
XML_ALTO_SUMMARY_MENU8 = "Calendar"

XML_ALTO_SUMMARY_TEXT1 = "Petición de compartir cuenta"
XML_ALTO_SUMMARY_TEXT2 = "Click en este botón para pedir a un jugador\n"
                .. "que comparta su base de datos de Altoholic entera\n"
                .. "y añadirla a la tuya"
XML_ALTO_SUMMARY_TEXT3 = "Ambas partes han de activar la compartición de cuenta\nantes de usar esta característica (ver opciones)"
XML_ALTO_SUMMARY_TEXT4 = "Compartición de cuenta"

XML_ALTO_CHAR_DD1 = "Reino"
XML_ALTO_CHAR_DD2 = "Personaje"
XML_ALTO_CHAR_DD3 = "Ver"

XML_ALTO_SEARCH_COL1 = "Objeto / Ubicación"

XML_ALTO_GUILD_TEXT1 = "Oculta esta hermandad de la lista"

XML_ALTO_ACH_NOTSTARTED = "No iniciado"
XML_ALTO_ACH_STARTED = "Iniciado"

XML_ALTO_OPT_MENU1 = "General"
XML_ALTO_OPT_MENU2 = "Buscar"
XML_ALTO_OPT_MENU3 = "Correo"
XML_ALTO_OPT_MENU4 = "Minimapa"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Totales";
XML_TEXT_2 = "Buscar contenedores";
XML_TEXT_3 = "Niveles";
XML_TEXT_4 = "Rareza";
XML_TEXT_5 = "Tipo de equipo";
XML_TEXT_6 = "Reiniciar";
XML_TEXT_7 = "Buscar";

XML_ALTO_TEXT10 = "Nombre de cuenta"
XML_ALTO_TEXT11 = "Mandar petición de compartir cuenta a:"


--Options.xml
XML_ALTO_OPT_GENERAL1 = "Mostrar el maximo de XP reposado como 150%";
XML_ALTO_OPT_GENERAL2 = "Mostrar icono FuBar";
XML_ALTO_OPT_GENERAL3 = "Mostrar texto FuBar";
XML_ALTO_OPT_GENERAL4 = "Compartición de cuenta activado";
XML_ALTO_OPT_GENERAL5 = "Comunicación con hermandad activada";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a otros usuarios\n"
                .. "de Altoholic enviarte peticiones para compartir cuenta.\n"
                .. "Se te pedirá confirmación cada vez que alguien solicite tu información.\n\n"
                .. "Si está |cFFFF0000desactivada|cFFFFFFFF, todas las peticiones serán automáticamente rechazadas.\n\n"
                .. "Consejo de seguridad: Actívalo sólo cuando necesites transferir datos,\ndesactívalo el resto del tiempo"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a tus compañeros de hermandad\n"
                .. "ver tus alters y sus profesiones.\n\n"
                .. "Si está |cFFFF0000desactivada|cFFFFFFFF, no habrá comunicación con la hermandad."
XML_ALTO_OPT_GENERAL8 = "Autorizar automáticamente las actualizaciones el banco de la hermandad"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a otros usuarios de Altoholic\n"
                .. "actualizar su información del banco de la hermandad con la tuya..\n\n"
                .. "Si está |cFFFF0000desactivada|cFFFFFFFF, se te pedirá confirmación\n"
                .. "antes de mandar ninguna información.\n\n"
                .. "Consejo de seguridad: desaciva esto si tienes permisos de oficial\n"
                .. "en pestañas del banco de la hermandad que no deben ser vistas por todos,\n"
                .. "y autoriza las peticiones manualmente"
XML_ALTO_OPT_GENERAL10 = "Transparency"

XML_ALTO_OPT_SEARCH1 = "Comprobación automática |cFFFF0000(riesgo de desconexión)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFSi un objeto no esta en la caché local de objetos\n"
                .. "y es encontrado mientras se realiza una búsqueda,\n"
                .. "Altoholic preguntará al servidor por 5 nuevos objetos.\n\n"
                .. "Esto mejorará gradualmente la consistencia de las busquedas,\n"
                .. "ya que habrá mas objetos en la cache de objetos.\n\n"
                .. "Aun así, hay un riesgo de desconexión al preguntar por un objeto\n"
                .. "si es un drop de una instancia de alto nivel.\n\n"
                .. "|cFF00FF00deshabilitar|r para evitar este riesgo";

XML_ALTO_OPT_SEARCH3 = "Ordenar saqueos en orden decreciente";
XML_ALTO_OPT_SEARCH4 = "Incluir objetos sin requerimientos de nivel";
XML_ALTO_OPT_SEARCH5 = "Incluir buzones de correo";
XML_ALTO_OPT_SEARCH6 = "Incluir bancos de hermandad";
XML_ALTO_OPT_SEARCH7 = "Incluir recetas conocidas";

XML_ALTO_OPT_MAIL1 = "Advertir cuando el correo expira en menos días que los indicados";
XML_ALTO_OPT_MAIL2 = "Advertencia de expiración del correo";
XML_ALTO_OPT_MAIL3 = "Analizar el contenido de los correos (marcarlos como leídos)";
XML_ALTO_OPT_MAIL4 = "Notificación de nuevo correo";
XML_ALTO_OPT_MAIL5 = "Serás avisado cuando un compañero de hermandad mande un correo a uno de tus alters.\n\n"
                .. "El contenido del correo se verá directamente sin tener que reconectar con ese personaje";

XML_ALTO_OPT_MINIMAP1 = "Mover para cambiar el ángulo del icono en el minimapa";
XML_ALTO_OPT_MINIMAP2 = "Angulo del icono del minimapa";
XML_ALTO_OPT_MINIMAP3 = "Mover para cambiar el angulo del icono en el minimapa";
XML_ALTO_OPT_MINIMAP4 = "Radio del icono del minimapa";
XML_ALTO_OPT_MINIMAP5 = "Mostrar icono del minimapa";

XML_ALTO_OPT_TOOLTIP1 = "Mostrar origen del objeto"; 
XML_ALTO_OPT_TOOLTIP2 = "Mostrar recuento de objetos por personaje";
XML_ALTO_OPT_TOOLTIP3 = "Mostrar recuento total de objetos";
XML_ALTO_OPT_TOOLTIP4 = "Mostrar recuento de objetos en el banco de la hermandad";
XML_ALTO_OPT_TOOLTIP5 = "Mostrar conocido/puede aprenderse por";
XML_ALTO_OPT_TOOLTIP6 = "Mostrar ID y nivel del objeto";
XML_ALTO_OPT_TOOLTIP7 = "Mostrar contadores en los nodos de recolección";
XML_ALTO_OPT_TOOLTIP8 = "Mostrar contadores de ambas facciones";
XML_ALTO_OPT_TOOLTIP9 = "Mostrar contadores de todas las cuentas";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";

XML_ALTO_OPT_CALENDAR1 = "Week starts on Monday"; 
XML_ALTO_OPT_CALENDAR2 = "Warn %d minutes before an event starts"; 
end
