(import (chicken foreign))

(foreign-declare 
    "#include <SDL2/SDL.h>")

(define-foreign-type sdl-window c-pointer)
(define-foreign-type sdl-renderer c-pointer)
(define-foreign-type sdl-texture c-pointer)
(define-foreign-type sdl-event c-pointer)

(define-external window sdl-window)
(define-external renderer sdl-renderer)
(define-external texture sdl-texture)
(define-external event sdl-event)

(define sdl-create-event
  (foreign-lambda*
   void
   ()
   "event = malloc(sizeof(SDL_Event));"))

(define sdl-create-window 
  (foreign-lambda*
   void
   ((c-string str))
   "window = SDL_CreateWindow(str, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 200, 200, 0);"))

(define sdl-create-renderer
  (foreign-lambda*
   void
   ()
   "renderer = SDL_CreateRenderer(window, -1, 0);"))

(define sdl-create-texture
  (foreign-lambda*
   void
   ((nonnull-c-string str))
   "SDL_Surface* surface = SDL_LoadBMP(str);
    texture = SDL_CreateTextureFromSurface(renderer, surface);
    SDL_FreeSurface(surface);"))

(define sdl-render-copy
  (foreign-lambda*
   void
   ((int srcx) (int srcy) (int srcw) (int srch)
    (int dstx) (int dsty) (int dstw) (int dsth))
   "SDL_Rect src = { .x = srcx, .y = srcy, .w = srcw, .h = srch };
    SDL_Rect dst = { .x = dstx, .y = dsty, .w = dstw, .h = dsth };
    SDL_RenderCopy(renderer, texture, &src, &dst);"))

(define sdl-poll-event
  (foreign-lambda*
   bool
   ()
   "C_return(SDL_PollEvent(event));"))

(define sdl-get-ticks
  (foreign-lambda
   unsigned-int32
   SDL_GetTicks))

(define sdl-delay
  (foreign-lambda
   void
   SDL_Delay
   unsigned-int32))

(print "Hello World")
(sdl-create-window "Demo")
(sdl-create-renderer)
(sdl-create-event)

(print (sdl-get-ticks))
(print (sdl-poll-event))

(sdl-delay 5000)
