/**
 * Created by Chelsea on 5/5/2014.
 */
package com.whatanadventure.framework.mvc
{
    import feathers.core.FeathersControl;

    import starling.events.Event;

    public class MVCView
    {
        public static const INVALIDATION_FLAG_ROTATE:String = "rotate";
        public static const INVALIDATION_MVC_LAYOUT:String = "mvc_layout";
        public static const INVALIDATION_FLAG_MVC_MODEL:String = "mvc_model";

        public function MVCView()
        {
        }

        public static function init(view:IMVCView):void
        {
            view.addModels();

            view.mvcLayout.init(view as FeathersControl);
        }

        public static function addModel(view:IMVCView, model:MVCModel, invalidationFlag:String = null):MVCModel
        {
            var result:MVCModel;

            if (view.controller.models.indexOf(model) == -1)
            {
                result = view.controller.models.push(model) as MVCModel;
                model.addEventListener(Event.CHANGE, function (event:Event):void {
                    (view as FeathersControl).invalidate(invalidationFlag);
                });
            }

            return result;
        }

        public static function dispose(view:IMVCView):void
        {
            for each (var model:MVCModel in view.controller.models)
            {
                model.removeEventListener(Event.CHANGE, view.onModelChange);
            }
        }

        public static function onRotate(view:FeathersControl):void
        {
            view.invalidate(MVCView.INVALIDATION_FLAG_ROTATE);
        }

        public static function onDraw(view:FeathersControl):void
        {
            if (view.isInvalid(MVCView.INVALIDATION_FLAG_ROTATE))
            {
                (view as IMVCView).mvcLayout.updateLayout();
            }
        }

        public static function onModelChange(view:FeathersControl, event:Event):void
        {
            view.invalidate(MVCView.INVALIDATION_FLAG_MVC_MODEL);
        }
    }
}
