/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.framework.mvc.layout
{
    import com.whatanadventure.framework.data.IJsonObject;

    import feathers.core.FeathersControl;

    public class MVCLayout implements IJsonObject
    {
        protected var _view:FeathersControl;

        protected var _layoutType:String;
        protected var _mvcType:String;
        protected var _mvcLayoutData:MVCLayoutData;
        protected var _viewId:String;
        protected var _navigations:Object;

        public function MVCLayout()
        {
            super();
        }

        public function set viewId(viewId:String):void
        {
            _viewId = viewId;
        }

        public function get viewId():String
        {
            return _viewId;
        }

        public function get layoutType():String
        {
            return _layoutType;
        }

        public function set layoutType(value:String):void
        {
            _layoutType = value;
        }

        public function get mvcType():String
        {
            return _mvcType;
        }

        public function set mvcType(value:String):void
        {
            _mvcType = value;
        }

        public function set mvcLayoutData(value:MVCLayoutData):void
        {
            _mvcLayoutData = value;
        }

        public function get mvcLayoutData():MVCLayoutData
        {
            return _mvcLayoutData;
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
            _layoutType = jsonData.layoutType;
            _mvcType = jsonData.mvcType;
            _viewId = jsonData.viewId;
            _navigations = jsonData.navigations;

            var layoutDataClass:Class = (this as ILayout).layoutDataClass;
            var mvcViewLayoutData:MVCLayoutData = new layoutDataClass(_viewId) as MVCLayoutData;
            (mvcViewLayoutData as IJsonObject).fromJSON(jsonData.layoutData);
            _mvcLayoutData = mvcViewLayoutData;
        }

        public function get navigations():Object
        {
            return _navigations;
        }
    }
}
