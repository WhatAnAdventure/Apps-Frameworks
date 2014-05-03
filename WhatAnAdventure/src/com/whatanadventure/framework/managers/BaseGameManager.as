/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import com.whatanadventure.framework.data.Fetcher;

    import starling.events.EventDispatcher;

    public class BaseGameManager extends EventDispatcher
    {
        public function BaseGameManager()
        {
            super();
        }
        protected var _modelManager:BaseModelManager;
        protected var _dataFecther:Fetcher;

        public function init():void
        {
            _modelManager = new BaseModelManager(this);
            _dataFecther = new Fetcher();
        }
    }
}
