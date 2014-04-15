@import basic

.uil-spin-css
  background: none
  position: relative
  width: 200px
  height: 200px

@mixin uil-spin-css($id,$left,$top,$deg,$delay)
  .uil-spin-css > div:nth-of-type(#{$id})
    top: #{$top}px
    left: #{$left}px
    & > div
      -webkit-animation: uil-spin-css-#{$id} 1s linear 0s infinite
      -webkit-animation-delay: $delay
      -webkit-transform: rotate(#{$deg}deg) scaleY(1)
      animation: enlarge#{$id} 1s ease-in-out 0s infinite
      animation-delay: $delay
      transform: rotate(#{$deg}deg) scaleY(1)
  +keyframes(uil-spin-css-#{$id})
    0%
      @include transform(rotate(#{$deg}deg) translate(0,0) scaleY(1))
      opacity: 0.68
    25%
      @include transform(rotate(#{$deg}deg) translate(0,0) scaleY(1))
      opacity: 0.86
    50%
      @include transform(rotate(#{$deg}deg) translate(0,-5px) scaleY(1.5))
      opacity: 1.0
    51%
      opacity: 0.2
    75%
      @include transform(rotate(#{$deg}deg) translate(0,0) scaleY(1))
      opacity: 0.36
    100%
      @include transform(rotate(#{$deg}deg) translate(0,0) scaleY(1))
      opacity: 0.52

.uil-spin-css > div
  position: absolute
  & > div
    width: 20px
    height: 20px
    background: #000
    border-radius: 10px

@include uil-spin-css(1,50,0,0,0s)
@include uil-spin-css(2,85,15,45,0.125s)
@include uil-spin-css(3,100,50,90,0.25s)
@include uil-spin-css(4,85,85,135,0.375s)
@include uil-spin-css(5,50,100,180,0.5s)
@include uil-spin-css(6,15,85,225,0.625s)
@include uil-spin-css(7,0,50,270,0.75s)
@include uil-spin-css(8,15,15,315,0.875s)
