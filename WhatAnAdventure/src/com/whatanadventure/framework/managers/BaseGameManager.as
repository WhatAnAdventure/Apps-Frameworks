/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import starling.events.EventDispatcher;

    public class BaseGameManager extends EventDispatcher
    {
        protected var _modelManager:BaseModelManager;
        protected var _resourceManager:BaseResourceManager;

        public function BaseGameManager()
        {
            super();
        }

        public function init():void
        {
        }

        public function get modelManager():BaseModelManager
        {
            return _modelManager;
        }

        public function get resourceManager():BaseResourceManager
        {
            return _resourceManager;
        }
    }
}
