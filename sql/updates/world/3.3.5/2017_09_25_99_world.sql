-- Add gossip text to menu
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (7559,7560);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7559,0,0,'Grant me your mark, wise ancient.',14739,1,3,0,0,0,0,'',0,-1),
(7560,0,0,'Grant me your mark, mighty ancient.',14741,1,3,0,0,0,0,'',0,-1);

-- Migrate NPC to use SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (17900,17901);

-- Create SAI
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17900, 0, 0, 0, 62, 0, 100, 0, 7559, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Close Gossip'),
(17900, 0, 1, 0, 62, 0, 100, 0, 7559, 0, 0, 0, 11, 31808, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\''),
(17900, 0, 2, 0, 62, 0, 100, 0, 7559, 0, 0, 0, 11, 31810, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\''),
(17900, 0, 3, 0, 62, 0, 100, 0, 7559, 0, 0, 0, 11, 31811, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\''),
(17900, 0, 4, 0, 62, 0, 100, 0, 7559, 0, 0, 0, 11, 31815, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\''),
(17901, 0, 0, 0, 62, 0, 100, 0, 7560, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Close Gossip'),
(17901, 0, 1, 0, 62, 0, 100, 0, 7560, 0, 0, 0, 11, 31807, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\''),
(17901, 0, 2, 0, 62, 0, 100, 0, 7560, 0, 0, 0, 11, 31812, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\''),
(17901, 0, 3, 0, 62, 0, 100, 0, 7560, 0, 0, 0, 11, 31813, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\''),
(17901, 0, 4, 0, 62, 0, 100, 0, 7560, 0, 0, 0, 11, 31814, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\'');
-- TODO: We also need to set the talkedtocreature flag per the existing c++ script for quest 9785 blessings of the ancients

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (7559,7560)) OR (`SourceTypeOrReferenceId` = 22 AND `SourceEntry` IN (17900,17901));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7559, 0, 0, 0, 5, 0, 942, 240, 0, 0, 0, 0, '', 'Show gossip menu 7559 option id 0 if player is Friendly or Honored or Revered or Exalted with faction Cenarion Expedition.'),
(15, 7560, 0, 0, 0, 5, 0, 942, 240, 0, 0, 0, 0, '', 'Show gossip menu 7560 option id 0 if player is Friendly or Honored or Revered or Exalted with faction Cenarion Expedition.'),
(22, 2, 17900, 0, 0, 5, 0, 942, 16, 0, 0, 0, 0, '', ' Id 1 of Creature SAI for EntryOrGuid 17900 will execute if player is Friendly with faction Cenarion Expedition.'),
(22, 3, 17900, 0, 0, 5, 0, 942, 32, 0, 0, 0, 0, '', ' Id 2 of Creature SAI for EntryOrGuid 17900 will execute if player is Honored with faction Cenarion Expedition.'),
(22, 4, 17900, 0, 0, 5, 0, 942, 64, 0, 0, 0, 0, '', ' Id 3 of Creature SAI for EntryOrGuid 17900 will execute if player is Revered with faction Cenarion Expedition.'),
(22, 5, 17900, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', ' Id 4 of Creature SAI for EntryOrGuid 17900 will execute if player is Exalted with faction Cenarion Expedition.'),
(22, 2, 17901, 0, 0, 5, 0, 942, 16, 0, 0, 0, 0, '', ' Id 1 of Creature SAI for EntryOrGuid 17901 will execute if player is Friendly with faction Cenarion Expedition.'),
(22, 3, 17901, 0, 0, 5, 0, 942, 32, 0, 0, 0, 0, '', ' Id 2 of Creature SAI for EntryOrGuid 17901 will execute if player is Honored with faction Cenarion Expedition.'),
(22, 4, 17901, 0, 0, 5, 0, 942, 64, 0, 0, 0, 0, '', ' Id 3 of Creature SAI for EntryOrGuid 17901 will execute if player is Revered with faction Cenarion Expedition.'),
(22, 5, 17901, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', ' Id 4 of Creature SAI for EntryOrGuid 17901 will execute if player is Exalted with faction Cenarion Expedition.');
