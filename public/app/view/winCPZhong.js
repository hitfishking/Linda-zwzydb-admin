/*
 * File: app/view/winCPZhong.js
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

Ext.define('Linda_db_admin.view.winCPZhong', {
    extend: 'Ext.window.Window',

    requires: [
        'Ext.grid.Panel',
        'Ext.grid.View',
        'Ext.grid.column.Number',
        'Ext.toolbar.Toolbar',
        'Ext.button.Button',
        'Ext.toolbar.Fill'
    ],

    height: 323,
    width: 571,
    layout: 'fit',
    title: 'Copy/Paste种信息',

    initComponent: function() {
        var me = this;

        Ext.applyIf(me, {
            items: [
                {
                    xtype: 'gridpanel',
                    height: 193,
                    store: 'ZhongStoreLocal',
                    viewConfig: {
                        itemId: 'winCPZhongView'
                    },
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'ke_id',
                            text: 'Ke_id'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'ke_name',
                            text: 'Ke_name'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shu_id2',
                            text: 'Shu_id2'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shu_name',
                            text: 'Shu_name'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'zhong_id',
                            text: 'Zhong_id'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'cname',
                            text: 'Cname'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'ldname',
                            text: 'Ldname'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'aliases',
                            text: 'Aliases'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'xingtai',
                            text: 'Xingtai'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'gongneng',
                            text: 'Gongneng'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'guanshang',
                            text: 'Guanshang'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'huaqi',
                            text: 'Huaqi'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'pics',
                            text: 'Pics'
                        },
                        {
                            xtype: 'numbercolumn',
                            dataIndex: 'pic_count',
                            text: 'Pic_count'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.genxi',
                            text: 'Shengtai.genxi'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.huminity',
                            text: 'Shengtai.huminity'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.light',
                            text: 'Shengtai.light'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.moisture',
                            text: 'Shengtai.moisture'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.nanyi',
                            text: 'Shengtai.nanyi'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.salt',
                            text: 'Shengtai.salt'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.shouming',
                            text: 'Shengtai.shouming'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.soil',
                            text: 'Shengtai.soil'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.sudu',
                            text: 'Shengtai.sudu'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'shengtai.temperature',
                            text: 'Shengtai.temperature'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.cankao_jiage',
                            text: 'Engineering.cankao_jiage'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.miaomu_guige',
                            text: 'Engineering.miaomu_guige'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.sheji_jianyi',
                            text: 'Engineering.sheji_jianyi'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.shibie_tezheng',
                            text: 'Engineering.shibie_tezheng'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.shigong_yaodian',
                            text: 'Engineering.shigong_yaodian'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.yanghu_yaodian',
                            text: 'Engineering.yanghu_yaodian'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.yingyong_quyu',
                            text: 'Engineering.yingyong_quyu'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.zhongzhi_midu',
                            text: 'Engineering.zhongzhi_midu'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'engineering.ziran_quyu',
                            text: 'Engineering.ziran_quyu'
                        }
                    ],
                    dockedItems: [
                        {
                            xtype: 'toolbar',
                            dock: 'bottom',
                            items: [
                                {
                                    xtype: 'button',
                                    handler: function(button, e) {

                                        selectedNode = this.up('gridpanel').down('#winCPZhongView').getSelectionModel().getSelection()[0];
                                        console.log(selectedNode);

                                        Ext.getStore('ZhongStoreLocal').remove(selectedNode);



                                    },
                                    text: '删除'
                                },
                                {
                                    xtype: 'button',
                                    handler: function(button, e) {

                                        zhongLocalStore = Ext.getStore('ZhongStoreLocal');
                                        zhongRemoteStore = Ext.getStore('ZhongStore');
                                        zhongForm = Ext.ComponentQuery.query('form[title="种编辑表单"]')[0];

                                        //----------------------------------------------------------

                                        if (zhongLocalStore.count() === 0) {
                                            Ext.MessageBox.alert('提示','目前没有可用于粘贴的记录拷贝! 请拷贝后再粘贴.');
                                            return;
                                        }

                                        if (zhongLocalStore.count() === 1){
                                            theRecord = zhongLocalStore.getAt(0);
                                            zhongRemoteStore.removeAll();
                                            zhongsAdded = zhongRemoteStore.add(theRecord);
                                            zhongsAdded[0].store = zhongRemoteStore;

                                            zhongForm.loadRecord(zhongsAdded[0]);
                                            console.log(zhongsAdded[0].store);
                                            return;
                                        }

                                        if (zhongLocalStore.count() > 1){
                                            theSelections = this.up('gridpanel').down('#winCPZhongView').getSelectionModel().getSelection();
                                            nLen = theSelections.length;

                                            if (nLen === 0){ //未选择，则提示选择
                                                Ext.MessageBox.alert('提示','有多条拷贝，请选择一条要粘贴的拷贝!');
                                                return false;
                                            }
                                            theRecord = theSelections[0];  //只对第一个选择有效;目前grid设置只能选择一个;
                                            zhongRemoteStore.removeAll();
                                            zhongsAdded = zhongRemoteStore.add(theRecord);

                                            zhongForm.loadRecord(zhongsAdded[0]);
                                            return;
                                        }


                                    },
                                    icon: 'icons/paste.png',
                                    scale: 'medium',
                                    text: '粘贴'
                                },
                                {
                                    xtype: 'tbfill'
                                },
                                {
                                    xtype: 'button',
                                    handler: function(button, e) {

                                        this.up('window').close();

                                    },
                                    text: '关闭'
                                }
                            ]
                        }
                    ]
                }
            ]
        });

        me.callParent(arguments);
    }

});