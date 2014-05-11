/**
 * Created by Chelsea on 4/27/2014.
 */
package com.whatanadventure.framework.mvc.view
{
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.mvc.IMVCView;
    import com.whatanadventure.framework.mvc.MVCController;
    import com.whatanadventure.framework.mvc.MVCView;
    import com.whatanadventure.framework.mvc.layout.ILayout;

    import feathers.controls.Screen;

    import starling.events.Event;

    public class MVCScreen extends Screen implements IMVCView
    {
        protected var _gameManager:BaseGameManager;

        protected var _mvcLayout:ILayout;
        protected var _mvcContoller:MVCController;

        public function MVCScreen()
        {
            super();
        }

        public function set gameManager(value:BaseGameManager):void
        {
            _gameManager = value;
        }

        override public function set screenID(value:String):void
        {
            super.screenID = value;

            MVCView.init(this);
        }

        public function addModels():void
        {
            MVCView.addModel(this, _mvcLayout.mvcLayoutData, MVCView.INVALIDATION_MVC_LAYOUT);
        }

        public function reinitialize():void
        {
            MVCView.onRotate(this);
        }

        override protected function draw():void
        {
            super.draw();

            MVCView.onDraw(this);
        }

        public function get controller():MVCController
        {
            return _mvcContoller;
        }

        public function onModelChange(event:Event):void
        {
            MVCView.onModelChange(this, event);
        }

        override public function dispose():void
        {
            super.dispose();

            MVCView.dispose(this);
        }

        public function get mvcLayout():ILayout
        {
            return _mvcLayout;
        }

        public function set mvcLayout(value:ILayout):void
        {
            _mvcLayout = value;
        }

        public function get viewId():String
        {
            return _screenID;
        }

        public function set controller(controller:MVCController):void
        {
            _mvcContoller = controller;
        }
    }
}
