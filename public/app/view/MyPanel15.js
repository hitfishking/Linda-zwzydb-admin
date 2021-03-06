/*
 * File: app/view/MyPanel15.js
 *
 * This file was generated by Sencha Architect version 3.0.4.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Ext JS 4.2.x library, under independent license.
 * License of Sencha Architect does not include license for Ext JS 4.2.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

Ext.define('Linda_db_admin.view.MyPanel15', {
    extend: 'Ext.panel.Panel',

    requires: [
        'Ext.grid.Panel',
        'Ext.grid.View',
        'Ext.grid.column.Column'
    ],

    height: 542,
    width: 559,
    title: 'My Panel',

    initComponent: function() {
        var me = this;

        Ext.applyIf(me, {
            items: [
                {
                    xtype: 'gridpanel',
                    height: 176,
                    title: 'My Grid Panel',
                    store: 'KeStore',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: '_id',
                            text: '_id'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'name',
                            text: 'Name'
                        }
                    ]
                }
            ]
        });

        me.callParent(arguments);
    }

});