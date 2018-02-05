UPDATE `engine4_activity_actiontypes` SET `body` = '{item:$subject} posted a {itemChild:$object:topic:$child_id} in the group {item:$object}: {body:$body}' WHERE `type` = 'group_topic_create';
UPDATE `engine4_activity_actiontypes` SET `body` = '{item:$subject} replied to a {itemChild:$object:topic:$child_id} in the group {item:$object}: {body:$body}' WHERE `type` = 'group_topic_reply';
