/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import com.whatanadventure.framework.mvc.MVCModel;

    import flash.utils.Dictionary;

    import starling.events.EventDispatcher;

    public class BaseModelManager extends EventDispatcher
    {
        public function BaseModelManager(gameManager:BaseGameManager)
        {
            super();

            _gameManager = gameManager;

            makeModels();
        }
        protected var _gameManager:BaseGameManager;
        protected var _models:Dictionary;

        public function getModel(modelName:String):MVCModel
        {
            return _models[modelName];
        }

        protected function makeModels():void
        {
            _models = new Dictionary();
        }

        protected function addModel(model:MVCModel):void
        {
            _models[model.name] = model;
        }
    }
}
