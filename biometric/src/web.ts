import { WebPlugin } from "@capacitor/core";
import {
  BiometricPlugin,
  AvailableResult,
  BiometricOptions,
} from "./definitions";

export class BiometricWeb
  extends WebPlugin
  implements BiometricPlugin
{
  constructor() {
    super();
  }
  isAvailable(): Promise<AvailableResult> {
    throw new Error("Method not implemented.");
  }

  async verifyIdentity(_options?: BiometricOptions): Promise<any> {
    throw new Error("Method not implemented.");
  }
}
