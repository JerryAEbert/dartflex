part of dartflex.events;

class CollectionEvent extends FrameworkEvent {
  CollectionEvent.construct(String ident, String type, {Object relatedObject: null}) : super.construct('CollectionEvent', type, relatedObject: relatedObject);

  factory CollectionEvent(String type, {Object relatedObject: null}) {
    return new CollectionEvent.construct('CollectionEvent', type, relatedObject: relatedObject);
  }

  static String COLLECTION_CHANGED = 'collectionChanged';
}

