




-- 菜单 SQL
INSERT INTO ruoyi.sys_menu
(menu_id, menu_name, parent_id, order_num, `path`, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2000, '服务管理', 0, 0, 'serve', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'component', 'admin', '2026-03-09 11:39:28', '', NULL, '');

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理项目', '2000', '1', 'project', 'serve/project/index', 1, 0, 'C', '0', '0', 'serve:project:list', '#', 'admin', sysdate(), '', null, '护理项目菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理项目查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'serve:project:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理项目新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'serve:project:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理项目修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'serve:project:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理项目删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'serve:project:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理项目导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'serve:project:export',       '#', 'admin', sysdate(), '', null, '');
