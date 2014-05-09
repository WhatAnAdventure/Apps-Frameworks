/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import com.whatanadventure.framework.mvc.MVCModel;
    import com.whatanadventure.framework.mvc.models.MVCViewLayouts;

    import flash.utils.Dictionary;

    import starling.events.EventDispatcher;

    public class BaseModelManager extends EventDispatcher
    {
        public static const MVC_VIEWS:String = "mvcViews";

        public static const MVC_VIEWS_CLASS:Class = MVCViewLayouts;

//        protected var _gameManager:BaseGameManager;
        protected var _models:Dictionary;

        public function BaseModelManager(/*gameManager:BaseGameManager*/)
        {
            super();

//            _gameManager = gameManager;

            makeModels();
        }

        public function getModel(modelName:String):MVCModel
        {
            return _models[modelName];
        }

        protected function makeModels():void
        {
            _models = new Dictionary();
        }

        protected function addModel(model:MVCModel):MVCModel
        {
            _models[model.name] = model;
            return _models[model.name];
        }

        public function get models():Dictionary
        {
            return _models;
        }
    }
}
