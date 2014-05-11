/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.mvc
{
    import starling.events.EventDispatcher;

    public class MVCController extends EventDispatcher
    {
        protected var _models:Vector.<MVCModel>;

        public function MVCController()
        {
            super();

            _models = new Vector.<MVCModel>();
        }

        protected function addModel(model:MVCModel):Boolean
        {
            var result:Boolean;

            if (_models.indexOf(model) == -1)
            {
                _models.push(model);
                result = true;
            }

            return result;
        }

        protected function removeModel(model:MVCModel):Boolean
        {
            var result:Boolean;

            if (_models.indexOf(model) != -1)
            {
                var removedViews:Vector.<MVCModel> = _models.splice(_models.indexOf(model), 1);
                result = (removedViews != null && removedViews.length > 0);
            }

            return result;
        }

        public function get models():Vector.<com.whatanadventure.framework.mvc.MVCModel>
        {
            return _models;
        }
    }
}
