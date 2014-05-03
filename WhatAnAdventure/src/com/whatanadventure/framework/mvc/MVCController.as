/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.mvc
{
    import feathers.core.FeathersControl;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class MVCController extends EventDispatcher
    {
        public function MVCController(model:MVCModel)
        {
            super();

            _model = model;
            _model.addEventListener(Event.CHANGE, onModelChange);
        }

        protected var _model:MVCModel;
        protected var _views:Vector.<FeathersControl>;

        protected function addView(view:FeathersControl):Boolean
        {
            var result:Boolean;

            if (_views.indexOf(view) == -1)
            {
                _views.push(view);
                result = true;
            }

            return result;
        }

        protected function removeView(view:FeathersControl):Boolean
        {
            var result:Boolean;

            if (_views.indexOf(view) != -1)
            {
                var removedViews:Vector.<FeathersControl> = _views.splice(_views.indexOf(view), 1);
                result = (removedViews != null && removedViews.length > 0);
            }

            return result;
        }

        protected function onModelChange(event:Event):void
        {
            for each (var view:FeathersControl in _views)
            {

            }
        }
    }
}
