/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.framework.mvc.layout
{
    import com.whatanadventure.framework.data.IJsonObject;

    import feathers.data.ListCollection;

    public class CenterButtonGroupLayout extends MVCViewLayoutData implements IJsonObject
    {
        private var _title:String;
        private var _dataProvider:ListCollection;

        public function CenterButtonGroupLayout()
        {
            super();
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
            _title = jsonData.title;
            _dataProvider = new ListCollection(jsonData.dataProvider);
        }

        public function get title():String
        {
            return _title;
        }

        public function get dataProvider():ListCollection
        {
            return _dataProvider;
        }
    }
}
