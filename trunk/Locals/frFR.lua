local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "frFR" )

if not L then return end

--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

if GetLocale() == "frFR" then
-- Altoholic.xml local
LEFT_HINT = "Clic-gauche pour |cFF00FF00ouvrir";
RIGHT_HINT = "Clic-droit pour |cFF00FF00déplacer";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."


XML_ALTO_SHARING_HINT1 = "Entrez un nom de compte qui sera utilisé\nà des fins |cFF00FF00d'afffichage|r uniquement.\n"
				.. "Ce nom peut être ce que vous voulez,\nil ne doit |cFF00FF00PAS|r forcément être le nom réel du compte.\n\n"
XML_ALTO_SHARING_HINT2 = "Ce champ |cFF00FF00ne peut pas|r être laissé vide."

XML_ALTO_TAB1 = "Résumé"
XML_ALTO_TAB2 = "Personnages"
XML_ALTO_TAB3 = "Recherche"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Options"

XML_ALTO_SUMMARY_MENU1 = "Résumé du compte"
XML_ALTO_SUMMARY_MENU2 = "Sacs"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Activité"
XML_ALTO_SUMMARY_MENU5 = "Membres de guilde"
XML_ALTO_SUMMARY_MENU6 = "Métiers de guilde"
XML_ALTO_SUMMARY_MENU7 = "Onglets banque de guilde"
XML_ALTO_SUMMARY_MENU8 = "Calendrier"

XML_ALTO_SUMMARY_TEXT1 = "Demande de partage de compte"
XML_ALTO_SUMMARY_TEXT2 = "Cliquez sur ce bouton pour demander\n"
				.. "à un joueur de partager sa base de donnée Altoholic\n"
				.. "et l'ajouter à la vôtre"
XML_ALTO_SUMMARY_TEXT3 = "Les deux côtés doivent avoir activé le partage de compte\navant de pouvoir utiliser cette fonctionalité (voir options)"
XML_ALTO_SUMMARY_TEXT4 = "Partage de compte"

XML_ALTO_CHAR_DD1 = "Royaume"
XML_ALTO_CHAR_DD2 = "Personnage"
XML_ALTO_CHAR_DD3 = "Voir"

XML_ALTO_SEARCH_COL1 = "Objet / Lieu"

XML_ALTO_GUILD_TEXT1 = "Cacher cette guilde dans le tooltip"

XML_ALTO_ACH_NOTSTARTED = "Pas commencé"
XML_ALTO_ACH_STARTED = "Commencé"

XML_ALTO_OPT_MENU1 = "Général"
XML_ALTO_OPT_MENU2 = "Recherche"
XML_ALTO_OPT_MENU3 = "Courrier"
XML_ALTO_OPT_MENU4 = "Minimap"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Totaux";
XML_TEXT_2 = "Recherche Conteneurs";
XML_TEXT_3 = "Niv. Min/Max";
XML_TEXT_4 = "Rareté";
XML_TEXT_5 = "Equipement";
XML_TEXT_6 = "R.à.z.";
XML_TEXT_7 = "Recherche";

XML_ALTO_TEXT10 = "Nom du compte"
XML_ALTO_TEXT11 = "Envoyer la demande de partage à:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "XP de repos max affichée comme 150%";
XML_ALTO_OPT_GENERAL2 = "Afficher l'icône FuBar";
XML_ALTO_OPT_GENERAL3 = "Afficher le texte FuBar";
XML_ALTO_OPT_GENERAL4 = "Partage de compte activé";
XML_ALTO_OPT_GENERAL5 = "Communication de guilde activée";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFFQuand elle est |cFF00FF00activée|cFFFFFFFF, cette option autorise les autres utilisateurs d'Altoholic\n"
				.. "à vous envoyer des demandes de partage de compte.\n"
				.. "Votre confirmation sera toujours requise à chaque fois que vous recevrez une demande de partage.\n\n"
				.. "Quand elle est |cFFFF0000désactivée|cFFFFFFFF, toutes ces requêtes seront automatiquement rejetées.\n\n"
				.. "Conseil Sécurité: N'activez cette option que quand vous devez transférer des donneés,\ndésactivez là le reste du temps"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFFQuand elle est |cFF00FF00activée|cFFFFFFFF, cette option autorise votre guilde\n"
				.. "à voir vos autres personnages et leurs métiers.\n\n"
				.. "Quand elle est |cFFFF0000désactivée|cFFFFFFFF, il n'y aura aucune communication avec la guilde."
XML_ALTO_OPT_GENERAL8 = "Autoriser automatiquement les mise-à-jours de la banque"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFFQuand elle est |cFF00FF00activée|cFFFFFFFF, cette option autorise les autres utilisateurs d'Altoholic\n"
				.. "à mettre à jour automatiquement leur données de banque de guilde avec les vôtres.\n\n"
				.. "Quand elle est |cFFFF0000désactivée|cFFFFFFFF, votre confirmation sera\n"
				.. "requise avant tout envoi d'information.\n\n"
				.. "Conseil Sécurité: désactivez cette option si vous avez des droits d'officier\n"
				.. "sur des onglets de banque de guilde qui ne peuvent pas être vus de tous,\n"
				.. "et autorisez les requêtes manuellement"
XML_ALTO_OPT_GENERAL10 = "Transparence"

XML_ALTO_OPT_SEARCH1 = "AutoQuery server |cFFFF0000(risques de déconnexion)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFSi un objet n'existant pas dans le cache local\n"
				.. "est rencontré lors d'une recherche dans la table des loots,\n"
				.. "Altoholic va tenter d'envoyer des requêtes au serveur pour valider 5 nouveaux objets.\n\n"
				.. "Ceci va graduellement améliorer la consistance des recherches,\n"
				.. "puisque plus d'objets seront disponibles dans le cache local.\n\n"
				.. "Il existe un risque de déconnexion si l'objet\n"
				.. "est un loot d'une instance haut niveau.\n\n"
				.. "|cFF00FF00Désactiver|r pour éviter ce risque";
XML_ALTO_OPT_SEARCH3 = "Tri des loots décroissant";
XML_ALTO_OPT_SEARCH4 = "Incl. les objets sans niveau requis";
XML_ALTO_OPT_SEARCH5 = "Incl. boites aux lettres";
XML_ALTO_OPT_SEARCH6 = "Incl. banque de guilde";
XML_ALTO_OPT_SEARCH7 = "Incl. recettes connues";

XML_ALTO_OPT_MAIL1 = "Avertir quand du courrier arrive à expiration\ndans moins de jours que cette valeur";
XML_ALTO_OPT_MAIL2 = "Avertis. d'expiration du courrier";
XML_ALTO_OPT_MAIL3 = "Lire le courrier (le marque comme lu)";
XML_ALTO_OPT_MAIL4 = "Alerte nouveau courrier";
XML_ALTO_OPT_MAIL5 = "Etre informé quand un membre de la guilde envoie du\ncourrier à un de mes personnages.\n\n"
				.. "Le contenu du courrier est directement visible sans avoir à reconnecter le personnage";

XML_ALTO_OPT_MINIMAP1 = "Déplacer pour changer l'angle de l'icône minimap";
XML_ALTO_OPT_MINIMAP2 = "Angle de l'icône minimap";
XML_ALTO_OPT_MINIMAP3 = "Déplacer pour changer le rayon de l'icône minimap";
XML_ALTO_OPT_MINIMAP4 = "Rayon de l'icône minimap";
XML_ALTO_OPT_MINIMAP5 = "Afficher l'icône minimap";

XML_ALTO_OPT_TOOLTIP1 = "Afficher la source de l'objet";
XML_ALTO_OPT_TOOLTIP2 = "Afficher le décompte par personnage";
XML_ALTO_OPT_TOOLTIP3 = "Afficher le décompte total";
XML_ALTO_OPT_TOOLTIP4 = "Afficher la banque de guilde";
XML_ALTO_OPT_TOOLTIP5 = "Afficher Déjà Connu/Peut être appris par";
XML_ALTO_OPT_TOOLTIP6 = "Afficher l'item ID et l'item level";
XML_ALTO_OPT_TOOLTIP7 = "Afficher les compteurs sur mines et plantes";
XML_ALTO_OPT_TOOLTIP8 = "Afficher les compteurs des deux factions";
XML_ALTO_OPT_TOOLTIP9 = "Afficher les compteurs de tous les comptes";
XML_ALTO_OPT_TOOLTIP10 = "Inclure la banque de guilde dans le décompte total";

XML_ALTO_OPT_CALENDAR1 = "Commencer la semaine le lundi"; 
XML_ALTO_OPT_CALENDAR2 = "Avertir %d minutes avant le début d'un évènement"; 
end
