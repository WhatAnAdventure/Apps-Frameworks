/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.framework.mvc.layout
{
    public class MVCLayout
    {
        protected var _layoutClass:String;
        protected var _mvcLayoutData:MVCLayoutData;
        protected var _viewId:String;

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

        public function get layoutClass():String
        {
            return _layoutClass;
        }

        public function set layoutClass(value:String):void
        {
            _layoutClass = value;
        }

        public function set mvcLayoutData(value:MVCLayoutData):void
        {
            _mvcLayoutData = value;
        }

        public function get mvcLayoutData():MVCLayoutData
        {
            return _mvcLayoutData;
        }
    }
}
