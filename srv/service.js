module.exports = srv => {

  const ENTITY_NOTIFICATION = 'ntfn_db_Notification';

  srv.on('GetBadgeNumber', req =>
    cds.tx(req).run(`SELECT * from ${ENTITY_NOTIFICATION} where NotificationCount = 1`).then(res => res.length));
  srv.on('GetBadgeNumberByIntent', async req => {
    const { NavigationIntent } = req.data;
    return await cds.tx(req).run(`SELECT * from ${ENTITY_NOTIFICATION} where NotificationCount = 1 and NavigationIntent = ${NavigationIntent}`).length;
  });

  srv.on('ResetBadgeNumber', req =>
    cds.tx(req).run(UPDATE(ENTITY_NOTIFICATION).set({NotificationCount: 0})));
  srv.on('ResetBadgeNumberByIntent', req => {
    const { NavigationIntent } = req.data;
    cds.tx(req).run(UPDATE(ENTITY_NOTIFICATION).set({NotificationCount: 0}).where({NavigationIntent: {'=': NavigationIntent}}));
  });

  srv.on('Dismiss', req => {
    const { NotificationId } = req.data;
    cds.tx(req).run(DELETE.from(ENTITY_NOTIFICATION).where({Id: {'=': NotificationId}}));
  });
  srv.on('DismissAll', req => {
    const { ParentId } = req.data;
    cds.tx(req).run(DELETE.from(ENTITY_NOTIFICATION).where({ParentId: {'=': ParentId}}));
  });

  srv.on('MarkRead', req => {
    const { NotificationId } = req.data;
    cds.tx(req).run(UPDATE(ENTITY_NOTIFICATION).set({IsRead: true}).where({Id: {'=': NotificationId}}));
  });

  srv.on('ExecuteAction', req => {
    const { NotificationId, ActionId } = req.data;

    return {
      Success: false,
      MessageText: 'Message Text',
      DeleteOnReturn: true
    }
  });
};
