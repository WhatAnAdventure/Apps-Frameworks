/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.framework.mvc.layout
{
    import starling.events.EventDispatcher;

    public class MVCViewLayout extends EventDispatcher
    {
        private var _viewId:String;
        private var _layoutClass:String;
        private var _layoutData:MVCViewLayoutData;

        public function MVCViewLayout()
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

        public function set layoutData(value:MVCViewLayoutData):void
        {
            _layoutData = value;
        }

        public function get layoutData():MVCViewLayoutData
        {
            return _layoutData;
        }
    }
}
