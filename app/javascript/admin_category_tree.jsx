import React, { Component, useState } from 'react';
import 'react-dom';
import 'react_ujs';
import { UncontrolledTreeEnvironment, Tree, StaticTreeDataProvider } from 'react-complex-tree';

const base_action_path = '/admin/categories';
const cx = (...classNames) => classNames.filter(cn => !!cn).join(' ');

export default function CategoryTree({ items, form_authenticity_token }) {
  const treeRef = React.useRef();
  const treeData = getStructuredTreeData(items);

  const dataProvider = new StaticTreeDataProvider(treeData, (item, data) => ({ ...item, data }));

  // Make sure expand/collapse icons are rendered properly on item drag/drop
  // https://github.com/lukasbach/react-complex-tree/pull/70#issuecomment-1196395999
  dataProvider.onChangeItemChildren = function (itemId, newChildren) {
    this.data.items[itemId].isFolder = newChildren.length > 0;
    this.data.items[itemId].children = newChildren;
    this.onDidChangeTreeDataEmitter.emit([itemId]);
  };

  const headers = {
    'X-CSRF-Token': form_authenticity_token,
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  function updateTree(items, target) {
    const id = items.map(x => x.index)[0];
    const parent_id = target.targetType === 'between-items'? target.parentItem : target.targetItem;
    fetch(`${base_action_path}/update_tree`, {
      method: 'post',
      credentials: 'include',
      headers,
      body: JSON.stringify({ id, parent_id })
    }).then(res => {
      if (!res.ok) console.log('Something went wrong');
    }).catch(console.error);
  }

  return (
    <div>
      <UncontrolledTreeEnvironment
        dataProvider={dataProvider}
        getItemTitle={item => item.data.title}
        canDragAndDrop={true}
        canReorderItems={true}
        canDropOnFolder={true}
        canDropOnNonFolder={true}
        canSearchByStartingTyping={true}
        viewState={{
          'root': {
            expandedItems: Object.keys(treeData).map(f => parseInt(f)).filter(x => x)
          }
        }}
        onDrop={updateTree}
        renderItem={({ item, depth, children, title, context, arrow }) => {
          const InteractiveComponent = context.isRenaming ? 'div' : 'button';
          const type = context.isRenaming ? undefined : 'button';
          return (
            <li
              {...(context.itemContainerWithChildrenProps)}
              className={cx(
                'rct-tree-item-li',
                item.isFolder && 'rct-tree-item-li-isFolder',
                context.isSelected && 'rct-tree-item-li-selected',
                context.isExpanded && 'rct-tree-item-li-expanded',
                context.isFocused && 'rct-tree-item-li-focused',
                context.isDraggingOver && 'rct-tree-item-li-dragging-over',
                context.isSearchMatching && 'rct-tree-item-li-search-match'
              )}>
              <div
                {...(context.itemContainerWithoutChildrenProps)}
                style={{ paddingLeft: `${(depth + 1) * 20}px` }}
                className={cx(
                  'rct-tree-item-title-container',
                  item.isFolder && 'rct-tree-item-title-container-isFolder',
                  context.isSelected && 'rct-tree-item-title-container-selected',
                  context.isExpanded && 'rct-tree-item-title-container-expanded',
                  context.isFocused && 'rct-tree-item-title-container-focused',
                  context.isDraggingOver &&
                    'rct-tree-item-title-container-dragging-over',
                  context.isSearchMatching &&
                    'rct-tree-item-title-container-search-match'
                )}>
                {arrow}
                <InteractiveComponent
                  type={type}
                  {...(context.interactiveElementProps)}
                  className={cx('rct-tree-item-button')}>
                  {title}
                  {context.viewStateFlags.activeItems ? ' (marked as active)' : ''}
                </InteractiveComponent>
                <a href={`${base_action_path}/${item.data.id}`} className="btn btn-link">
                  View
                </a>
              </div>
              {children}
            </li>
          );
        }}>
        <Tree treeId="root" rootItem="root" treeLabel="Root" ref={treeRef} />
      </UncontrolledTreeEnvironment>
    </div>
  );
}

// returns Tree structure in StaticTreeDataProvider format
// https://rct.lukasbach.com/docs/api/classes/StaticTreeDataProvider
function getStructuredTreeData(rawData) {
  function traverse(items) {
    return items.map(({ id, name, title, children }) => ({
      children,
      index: id,
      data: { id, name, title, children },
      isFolder: children.length > 0,
      canMove: true,
      canRename: false,
    })).reduce((all, item) => {
      all[item.index] = item;
      if (item.isFolder) return { ...all, ...traverse(item.children) }
      return all;
    }, {});
  }
  const data = traverse(rawData);
  Object.keys(data).forEach(k => {
    if (data[k].children.length > 0) data[k].children = data[k].children.map(c => c.id)
  });

  data['root'] = {
    children: rawData.map(u => u.id),
    index: 'root',
    data: { id: 'root', name: 'root' },
    isFolder: true,
    canMove: true,
    canRename: false,
  };

  return data;
}
